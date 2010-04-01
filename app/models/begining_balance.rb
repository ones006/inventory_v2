class BeginingBalance < Transaction
  belongs_to :company
  belongs_to :destination_warehouse, :class_name => "Warehouse", :foreign_key => :destination_id
  has_many :entries, :foreign_key => :transaction_id, :dependent => :destroy
  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => proc { |a| a['quantity'].blank? }
  validates_presence_of :number
  attr_writer :category_name

  def category_name
    @category_name || entries.first.try(:item).try(:category).try(:name)
  end

  def self.suggested_number(company)
    last_number = super(company, self.to_s)
    next_available = last_number.nil? ? '00001' : sprintf('%05d', last_number.split('.').last.to_i + 1)
    time = Time.now
    prefix = "#{TRANS_PREFIX[:begining_balance]}.#{time.strftime('%Y%m')}"
    "#{prefix}.#{next_available}"
  end

end
