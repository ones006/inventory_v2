class Entry < ActiveRecord::Base
  belongs_to :item
  belongs_to :plu
  belongs_to :company
  belongs_to :begining_balance, :foreign_key => :transaction_id
  validates_presence_of :quantity
  attr_writer :plu_code
  before_save :assign_item_id

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
