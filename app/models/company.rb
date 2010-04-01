class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :users
  has_many :categories
  has_many :items
  has_many :suppliers
  has_many :plus
  has_many :warehouses
  has_many :locations
  has_many :begining_balances
  has_many :item_transfers

  def default_warehouse
    warehouses.first(:conditions => { :default => true })
  end

  def sorted_categories
    cat = []; categories.roots.each do |root|
      cat << root << root.descendants
    end
    cat.flatten
  end

  def leaf_categories
    categories.reject { |cat| !cat.leaf? }
  end
end
