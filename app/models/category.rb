class Category < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :company_id, :name, :description, :parent_id, :lft, :rgt
  belongs_to :company
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :company_id
end
