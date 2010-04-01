class ItemTransfer < Transaction
  belongs_to :company  
  belongs_to :originator_warehouse, :class_name => 'Warehouse'
  belongs_to :destination_warehouse, :class_name => 'Warehouse'
  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :company_id
  attr_accessor :originator_warehouse_id, :destination_warehouse_id
  attr_writer :originator_warehouse, :destination_warehouse

  def self.suggested_number(company)
    last_number = super(company, self.to_s)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX['item_transfer']}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end
end
