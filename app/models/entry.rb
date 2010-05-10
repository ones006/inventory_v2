class Entry < ActiveRecord::Base
  belongs_to :item
  belongs_to :plu
  belongs_to :company
  belongs_to :transaction, :foreign_key => :transaction_id
  validates_presence_of :quantity
  attr_writer :plu_code, :validating_quantity, :warehouse_id
  before_save :assign_item_id
  before_save :assign_company_id
  before_save :assign_value
  has_many :trackers, :foreign_key => :consumer_entry_id, :dependent => :destroy
  has_many :details, :class_name => 'EntryDetail', :dependent => :destroy

  named_scope :for_transactions, lambda { |ids|
    { :conditions => { :transaction_id => ids } }
  }

  named_scope :from_inward_transactions,
              :joins => :transaction,
              :conditions => "transactions.origin_id IS NULL AND transactions.destination_id > 0"

  named_scope :with_item, lambda { |item|
    { :conditions => { :item_id => item } }
  }

  named_scope :until, lambda { |time|
    { :conditions => [ "created_at < ?", time ] }
  }

  def self.transaction_inward
    transaction_origin_id_null.transaction_destination_id_not_null
  end

  def self.transaction_outward
    transaction_origin_id_not_null.transaction_destination_id_null
  end

  def validate
    if @validating_quantity  && !quantity.blank?
      stock = Warehouse.find(@warehouse_id).item_quantity(Plu.find(plu_id).item)
      # stock = Entry.quantity_in_warehouse(@warehouse_id, plu_id)
      errors.add(:quantity, "of #{plu.item.name} exceeded actual stock (#{stock})") if (!quantity.blank? && quantity > stock)
    end
  end

  def validating_quantity?
    @validating_quantity
  end

  def self.quantity_in_warehouse(warehouse, plu)
    item = Plu.find(plu).item
    Warehouse.find(warehouse).item_quantity(item)
  end

  def total_value
    value * quantity
  end

  def plu_code
    @plu_code || plu.try(:code)
  end

  def assign_item_id
    self.item_id = Plu.find(self.plu_id).item_id unless self.plu_id.blank?
  end

  def assign_company_id
    self.company_id = transaction.company_id
  end

  def assign_value
    if transaction.inward? && value.blank?
      last_entry = Entry.item_id_is(item_id).transaction_origin_id_is_null.transaction_destination_id_not_null.transaction_alter_stock_is(true).last
      self.value = last_entry.blank? ? 0 : last_entry.value
    end
  end

  def track_details(ref_entry_detail = nil)
    if transaction.inward?
      EntryDetail.create(:entry_id => id,
                         :ref_entry_detail_id => nil,
                         :quantity => quantity,
                         :used_up => false,
                         :available_quantity => quantity,
                         :value => value)
    else
      while required_quantity > 0
        create_entry_detail
      end
    end
  end

  def required_quantity
    @required_quantity ||= quantity
  end

  def create_entry_detail
    ref_entry_detail = first_ref_entry_detail
    req_quantity = ref_entry_detail.available_quantity <= required_quantity ? ref_entry_detail.available_quantity : required_quantity
    used_up = transaction.outward? ? true : false
    EntryDetail.create(:entry_id => id,
                       :ref_entry_detail_id => ref_entry_detail.id,
                       :quantity => req_quantity,
                       :available_quantity => req_quantity,
                       :used_up => used_up,
                       :value => ref_entry_detail.value)
    @required_quantity = @required_quantity - req_quantity
    ref_entry_detail.update_attributes(:available_quantity => (ref_entry_detail.available_quantity - req_quantity),
                                       :used_up => (ref_entry_detail.available_quantity - req_quantity) == 0)
  end

  def first_ref_entry_detail
    if item.fifo?
      EntryDetail.used_up_is(false).entry_transaction_destination_id_is(transaction.origin_id).entry_item_id_is(item_id).first(:readonly => false)
    else
      EntryDetail.used_up_is(false).entry_transaction_destination_id_is(transaction.origin_id).entry_item_id_is(item_id).last(:readonly => false)
    end
  end

  def calculated_value
    if transaction.outward?
      tmp_value = 0
      if item.fifo? || item.lifo?
        details.each do |detail|
          tmp_value = tmp_value + detail.total_value
        end
        tmp_value
      elsif item.average?
        (average_value * quantity)
      end
    else
      quantity * (value.blank? ? 0 : value)
    end
  end

  def average_value
    in_entries = company.entries.from_inward_transactions.with_item(item).transaction_created_at_before(transaction.created_at)
    in_entries.sum("entries.value * entries.quantity") / in_entries.sum(:quantity)
  end
end
