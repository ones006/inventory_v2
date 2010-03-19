class Item < ActiveRecord::Base
  attr_accessible :code, :name, :description, :category_name, :units_attributes
  belongs_to :company
  belongs_to :category
  has_many :units
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_presence_of :category_name, :message => "category can't be blank"
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda {|a| a['name'].blank? }

  def category_name
    @category_name || category.try(:name)
  end

  def category_name=(name)
    if name.blank?
      self.category = nil
    else
      self.category = Category.find_by_name(name)
    end
  end

  def stock
    entries = []
    company.begining_balances.each do |bb|
      entries << bb.entries.reject { |entry| entry.item_id != id }
    end
    entries.flatten.collect { |entry| entry.quantity }.sum
  end
end
