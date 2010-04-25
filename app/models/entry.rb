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

  named_scope :for_transactions, lambda { |ids|
    { :conditions => { :transaction_id => ids } }
  }

  def validate
    if @validating_quantity  && !quantity.blank?
      stock = Entry.quantity_in_warehouse(@warehouse_id, plu_id)
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
      last_entry = Entry.first(:joins => :transaction,
                               :conditions => ["entries.item_id = ? AND transactions.origin_id IS NULL AND transactions.destination_id > 0 AND alter_stock = 1", item_id],
                               :order => "created_at DESC")
      self.value = last_entry.blank? ? 0 : last_entry.value
    end
  end

  def track
    if item.fifo? && transaction.outward?
      initial_qty = quantity
      while true
        tracker = item.available_tracker
        if tracker.nil?
          closed_trackers = item.closed_trackers.map(&:stock_entry_id)
          closed_transactions = closed_trackers.blank? ? [] : Transaction.entries_id_in(closed_trackers).uniq
          ref = company.transactions.inward.altering_stock.contain(item).not_in(closed_transactions).first
          ref_entry = ref.entries.first(:conditions => { :item_id => item })
          initial_qty = company.trackers.new.log(self, initial_qty,  ref_entry)
        else
          initial_qty = tracker.log(self, initial_qty)
        end
        if initial_qty <= 0
          break
        end
      end
    elsif item.lifo? && transaction.outward?
      initial_qty = quantity
      while true
        tracker = item.available_tracker
        if tracker.nil?
          closed_trackers = item.closed_trackers.map(&:stock_entry_id)
          closed_transactions = closed_trackers.blank? ? [] : Transaction.entries_id_in(closed_trackers).uniq
          ref = company.transactions.inward.altering_stock.contain(item).not_in(closed_transactions).last
          ref_entry = ref.entries.first(:conditions => { :item_id => item })
          initial_qty = company.trackers.new.log(self, initial_qty,  ref_entry)
        else
          initial_qty = tracker.log(self, initial_qty)
        end
        if initial_qty <= 0
          break
        end
      end
    end
  end

  def calculated_value
    if transaction.outward?
      tmp_value = 0
      if item.fifo? || item.lifo?
        trackers = Tracker.all(:conditions => { :consumer_entry_id => id })
        trackers.each do |tracker|
          tmp_value = tmp_value + (tracker.value * tracker.consumed_stock)
        end
        tmp_value
      end
    else
      value * quantity
    end
  end
end
