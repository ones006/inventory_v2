class GeneralTransaction < Transaction
  attr_writer :validating_origin, :validating_destination
  belongs_to :company  
  belongs_to :transaction_type
  belongs_to :originator_warehouse, :class_name => 'Warehouse', :foreign_key => :origin_id
  belongs_to :destination_warehouse, :class_name => 'Warehouse', :foreign_key => :destination_id
  has_many :entries, :foreign_key => :transaction_id, :dependent => :destroy

  validates_presence_of :number
  validates_presence_of :transaction_type
  validates_presence_of :origin_id, :if => :should_validate_origin?
  validates_presence_of :destination_id, :if => :should_validate_destination?
  validates_uniqueness_of :number, :scope => :company_id

  accepts_nested_attributes_for :entries, :allow_destroy => true, :reject_if => proc { |a| a['quantity'].blank? }

  def should_validate_origin?
    @validating_origin
  end

  def should_validate_destination?
    @validating_destination
  end
end
