class TransactionType < ActiveRecord::Base
  attr_accessible :company_id, :code, :description, :direction, :negate, :alter_date, :name, :alter_stock
  belongs_to :company
  has_many :general_transactions
  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :code, :scope => :company_id
  validates_uniqueness_of :name, :scope => :company_id
  validates_uniqueness_of :description

  def to_s
    name
  end

  def next_available_number
    last_number = GeneralTransaction.last(:conditions => ["number LIKE ?", "#{code}%"]).try(:number)
    prefix = last_number.split('.').first unless last_number.nil?
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{code}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def entries_value
    direction == 0 || direction == 2
  end

  def should_validating_quantity?
    direction == 1 || direction == 2
  end

end
