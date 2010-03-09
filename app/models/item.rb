class Item < ActiveRecord::Base
  attr_accessible :code, :name, :description, :category_name
  belongs_to :company
  belongs_to :category
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_presence_of :category_name, :message => "category can't be blank"
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"

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
end
