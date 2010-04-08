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
    ids = Transaction.destined_to(id).map(&:id)
    entries = Entry.for_transactions(ids).all(:group => :item_id).map(&:item_id)
    Item.all(:conditions => {:id => entries})
  end

  def managed_items_quantity
    items = {}; managed_items.each { |item| items[item.id] = company.stock.item_on_hand_per_warehouse(self, item) }; items
  end
end
