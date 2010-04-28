class Transaction < ActiveRecord::Base
  belongs_to :company
  has_many :entries

  default_scope :order => "created_at"
  named_scope :inward, :conditions => [ "origin_id IS NULL AND destination_id > ?", 0 ], :order => :created_at
  named_scope :outward, :conditions => [ "origin_id > ? AND destination_id IS NULL", 0 ], :order => :created_at
  named_scope :transfer, :conditions => [ "origin_id > ? AND destination_id > ?", 0, 0 ], :order => :created_at

  named_scope :contain, lambda { |itemid|
    { :joins => :entries, :conditions => [ 'entries.item_id = ?', itemid ] }
  }

  named_scope :destined_to, lambda { |destination|
    return {} if destination.blank?
    { :conditions => { :destination_id => destination.is_a?(Warehouse) ? destination.id : destination } }
  }

  named_scope :originated_from, lambda { |origin|
    return {} if origin.blank?
    { :conditions => { :origin_id => origin.is_a?(Warehouse) ? origin.id : origin } }
  }

  named_scope :altering_stock, :conditions => { :alter_stock => true }

  named_scope :since, lambda { |time|
    return {} if time.blank?
    { :conditions => [ 'created_at >= ?', time ] }
  }

  named_scope :until, lambda { |time|
    return {} if time.blank?
    { :conditions => [ 'created_at <= ?', time ] }
  }

  named_scope :between, lambda { |start, finish|
    return {} if start.blank? || finish.blank?
    { :conditions => { :created_at => (start.beginning_of_day..finish.end_of_day) } }
  }

  named_scope :not_in, lambda { |ids|
    return {} if ids.blank?
    { :conditions => [ "transactions.id NOT IN (?)", ids ] }
  }

  after_save :run_trackers

  def self.suggested_number(company, type)
    first(:conditions => { :company_id => company.id, :type => type },
         :order => 'created_at DESC').try(:number)
  end

  def total_value
    total = 0; entries.each { |entry| total = total + entry.calculated_value }; total
  end

  def item_quantity_for(item_id)
    entries.first(:select => :quantity, :conditions => { :item_id => item_id }).quantity
  end

  def available_quantity_for(item)
    initial_quantity = item_quantity_for(item)
    used_quantity = trackers.sum(:consumed_stock)
    initial_quantity - used_quantity
  end

  def outward?
    !origin_id.nil? && destination_id.nil?
  end

  def inward?
    origin_id.nil? && !destination_id.nil?
  end

  def run_trackers
    entries.each do |entry|
      entry.track
    end
  end

  def contain?(item)
    !entries.all(:conditions => [ 'entries.item_id = ?', item ]).blank?
  end

end
