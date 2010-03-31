class TransactionType < ActiveRecord::Base
  attr_accessible :company_id, :code, :description, :direction, :negate, :alter_date
  belongs_to :company
  validates_presence_of :code
  validates_presence_of :description
  validates_uniqueness_of :code
  validates_uniqueness_of :description
end
