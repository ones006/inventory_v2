class Warehouse < ActiveRecord::Base
  attr_accessible :code, :name, :address, :company_id
  belongs_to :company
  has_many :locations
  accepts_nested_attributes_for :locations
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"
end
