class Plu < ActiveRecord::Base
  attr_accessible :item_id, :supplier_id, :payment_term, :company_id, :code
  belongs_to :item
  belongs_to :supplier
  belongs_to :company
  validates_presence_of :code
  validates_presence_of :item_name
  validates_presence_of :item_id
  validates_presence_of :supplier_name
  validates_presence_of :supplier_id
  validates_presence_of :payment_term
  validates_uniqueness_of :code, :scope => :company_id
  attr_accessor :item_name, :supplier_name

  def item_name
    @item_name || item.try(:name)
  end

  def supplier_name
    @supplier_name || supplier.try(:name)
  end

  def item_name_with_code
    item.name_with_code
  end
end
