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
  has_many :item_ins
  has_many :item_outs
  has_many :transaction_types
  has_many :general_transactions
  has_many :trackers
  has_many :transactions
  has_many :entries

  default_scope :order => :created_at

  def next_stock
    available = trackers.available_transaction
    available.blank? ? transactions.inward.first : available
  end

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

  def first_transaction_date
    Transaction.first(:conditions => { :company_id => self.id }, :order => 'created_at ASC').created_at
  end

  def stock
    @stock || Stock.new(self)
  end
end
