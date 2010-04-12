class Entry < ActiveRecord::Base
  belongs_to :item
  belongs_to :plu
  belongs_to :company
  belongs_to :transaction, :foreign_key => :transaction_id
  validates_presence_of :quantity
  attr_writer :plu_code, :validating_quantity, :warehouse_id
  before_save :assign_item_id

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

  named_scope :for_transactions, lambda { |ids|
    { :conditions => { :transaction_id => ids } }
  }

  def total_value
    value * quantity
  end

  def plu_code
    @plu_code || plu.try(:code)
  end

  private
  def assign_item_id
    self.item_id = Plu.find(self.plu_id).item_id unless self.plu_id.blank?
  end
end
