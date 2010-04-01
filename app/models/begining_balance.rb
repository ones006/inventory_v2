class BeginingBalance < Transaction
  belongs_to :company
  has_many :entries, :foreign_key => :transaction_id
  accepts_nested_attributes_for :entries
  validates_presence_of :number
  attr_writer :category_name

  def category_name
    @category_name || entries.first.try(:item).try(:category).try(:name)
  end

  def self.suggested_number(company)
    super(company, self.to_s)
  end

end
