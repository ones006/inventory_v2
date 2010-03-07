class Category < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :company
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :company_id
  attr_accessor :parent_name
  after_save :assign_parent

  def parent_name
    @parent_name || parent.try(:name)
  end

  private
  def assign_parent
    unless @parent_name.blank?
      my_parent = company.categories.find_or_create_by_name(@parent_name)
      move_to_child_of my_parent
    else
      unless root?
        move_to_root
      end
    end
  end
end
