class Item < ActiveRecord::Base
  attr_accessible :code, :name, :description, :category_code, :category_id, :units_attributes, :count_method
  belongs_to :company
  belongs_to :category
  has_many :units
  has_many :plus
  validates_presence_of :code, :message => "code can't be blank"
  validates_presence_of :name, :message => "name can't be blank"
  validates_presence_of :category_code, :message => "category can't be blank"
  validates_presence_of :count_method
  validates_uniqueness_of :code, :scope => :company_id, :message => "code has already been taken"
  accepts_nested_attributes_for :units, :allow_destroy => true, :reject_if => lambda {|a| a['name'].blank? }
  attr_accessor :on_hand_stock

  acts_as_reportable

  def available_tracker
    company.trackers.first(:conditions => { :item_id => id, :closed => false }, :order => "available_stock ASC")
  end

  def closed_trackers
    company.trackers.all(:conditions => { :item_id => id, :closed => true }, :group => :stock_entry_id)
  end

  def category_code
    @category_code || category.try(:formatted_code)
  end

  def name_with_code
    "#{name} (#{code})"
  end

  def category_code=(catcode)
    self.category = Category.find_by_code(catcode.split.first) unless catcode.blank?
  end

  def category_tree
    "#{category.ancestors.map(&:name).join(' &gt; ')} &gt; #{category.name}"
  end

  def stock
    ins = company.entries.item_id_is(id).transaction_inward.transaction_alter_stock_is(true).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_outward.transaction_alter_stock_is(true).sum(:quantity)
    ins - out
  end

  def on_hand_between(start = nil, finish = nil)
    date_start = Chronic.parse(start || '01/01/1970').beginning_of_day
    date_end = Chronic.parse(finish || 'today').end_of_day
    ins = company.entries.item_id_is(id).transaction_inward.transaction_alter_stock_is(true).transaction_created_at_gte(date_start).transaction_created_at_lte(date_end).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_outward.transaction_alter_stock_is(true).transaction_created_at_gte(date_start).transaction_created_at_lte(date_end).sum(:quantity)
    ins - out
  end

  def sum_on_hand_between(start, finish)
    @on_hand_stock = on_hand_between(start, finish)
  end

  def quantity_in_warehouse(warehouse)
    ins = company.entries.item_id_is(id).transaction_destination_id_is(warehouse).transaction_alter_stock_is(true).sum(:quantity)
    out = company.entries.item_id_is(id).transaction_origin_id_is(warehouse).transaction_alter_stock_is(true).sum(:quantity)
    ins - out
  end

  def fifo?
    count_method == 'fifo'
  end

  def average?
    count_method == 'avg'
  end

  def lifo?
    count_method == 'lifo'
  end
end
