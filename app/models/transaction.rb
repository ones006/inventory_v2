class Transaction < ActiveRecord::Base
  belongs_to :company
  has_many :entries
  accepts_nested_attributes_for :entries
end
