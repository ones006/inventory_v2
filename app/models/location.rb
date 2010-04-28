class Location < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :warehouse
  belongs_to :company
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => [:company_id, :warehouse_id]
  attr_writer :parent_code
  after_save :assign_parent

  def parent_code
    @parent_code || parent.try(:code)
  end

  private
  def assign_parent
    move_to_child_of(company.locations.find_by_code(@parent_code)) unless @parent_code.blank?
  end
end
