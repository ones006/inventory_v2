class Transaction < ActiveRecord::Base
  named_scope :inward, :conditions => [ "origin_id IS NULL AND destination_id > ?", 0 ]
  named_scope :outward, :conditions => [ "origin_id > ? AND destination_id IS NULL", 0 ]
  named_scope :transfer, :conditions => [ "origin_id > ? AND destination_id > ?", 0, 0 ]

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

  named_scope :between,lambda { |start, finish|
    return {} if start.blank? || finish.blank?
    { :conditions => { :created_at => (start.beginning_of_day..finish.end_of_day) } }
  }


  def self.suggested_number(company, type)
    first(:conditions => { :company_id => company.id, :type => type },
         :order => 'created_at DESC').try(:number)
  end
end
