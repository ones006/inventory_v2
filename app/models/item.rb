class Item < ActiveRecord::Base
  attr_accessible :category_id, :code, :name, :description
  belongs_to :company
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_uniqueness_of :code, :scope => :company_id
end
