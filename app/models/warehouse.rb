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

  def setasdefault
    current_default = Warehouse.first(:conditions => { :company_id => company.id, :default => true })
    self.transaction do
      begin
        current_default.update_attributes(:default => false)
        self.update_attributes(:default => true)
      rescue
        return false
      end
    end
  end

  def managed_items
    transactions = Transaction.all(:conditions => {:company_id => company.id, :destination_id => id}).map(&:id)
    entries = Entry.all(:conditions => {:transaction_id => transactions}, :group => :item_id).map(&:item_id)
    Item.all(:conditions => {:id => entries})
  end

  def managed_items_quantity
    transactions_in = Transaction.all(:conditions => { :company_id => company.id,
                                   :destination_id => id }).map(&:id)
    transactions_out = Transaction.all(:conditions => { :company_id => company.id,
                                       :origin_id => id}).map(&:id)
    items_in = Entry.calculate(:sum, :quantity, :conditions => { :transaction_id => transactions_in }, :group => :item_id)
    items_out = Entry.calculate(:sum, :quantity, :conditions => { :transaction_id => transactions_out }, :group => :item_id)
    items_in.each do |k,v|
      items_in['k'] = v - items_out['k'] unless items_out['k'].nil?
    end
    items_in
  end
end
