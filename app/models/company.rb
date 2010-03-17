class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :users
  has_many :categories
  has_many :items
  has_many :suppliers
  has_many :plus
  has_many :warehouses
  has_many :transactions

  def sorted_categories
    cat = []; categories.roots.each do |root|
      cat << root << root.descendants
    end
    cat.flatten
  end
end
