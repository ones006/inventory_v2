class Entry < ActiveRecord::Base
  belongs_to :item
  belongs_to :company
  belongs_to :begining_balance, :foreign_key => :transaction_id
  validates_presence_of :quantity
end
