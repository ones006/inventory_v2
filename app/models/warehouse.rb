class Warehouse < ActiveRecord::Base
  attr_accessible :code, :name, :address, :company_id, :default
  belongs_to :company
  has_many :locations
  accepts_nested_attributes_for :locations
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"

  def sorted_locations
    sorted_locations = []
    roots = locations.reject { |loc| !loc.root? }
    roots.each do |loc|
      sorted_locations << loc
      sorted_locations << loc.descendants unless loc.descendants.blank?
    end
    sorted_locations.flatten
  end
end
