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

  def number_suggestion
    "#{transaction_type.next_available_number} is available"
  end

  def should_validate_origin?
    @validating_origin
  end

  def should_validate_destination?
    @validating_destination
  end

  def before_validation
    if transaction_type.should_validating_quantity?
      entries.each do |ent| 
        ent.validating_quantity = true
        ent.warehouse_id = destination_id
      end
    end
  end

  def before_save
    unless transaction_type.blank?
      self.alter_stock = transaction_type.alter_stock? ? true : false
      case transaction_type.direction
      when 0
        self.origin_id = nil
      when 1
        self.destination_id = nil
      end
    end
  end
end
