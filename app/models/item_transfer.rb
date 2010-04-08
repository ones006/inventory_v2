class ItemTransfer < Transaction
  belongs_to :company  
  belongs_to :originator_warehouse, :class_name => 'Warehouse', :foreign_key => :origin_id
  belongs_to :destination_warehouse, :class_name => 'Warehouse', :foreign_key => :destination_id
  validates_presence_of :number
  validates_presence_of :origin_id
  validates_presence_of :destination_id
  validates_uniqueness_of :number, :scope => :company_id
  attr_accessor :originator_warehouse, :destination_warehouse
  has_many :entries, :foreign_key => :transaction_id, :dependent => :destroy
  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => proc { |a| a['quantity'].blank? }

  def validate
    errors.add(:destination_warehouse, 'Both Originator and destination warehouse cannot be the same') if origin_id == destination_id
  end

  def self.suggested_number(company)
    last_number = super(company, self.to_s)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:item_transfer]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

  def originator_warehouse
    Warehouse.find(origin_id)
  end

  def destination_warehouse
    Warehouse.find(destination_id)
  end
end
