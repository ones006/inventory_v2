class Placement < ActiveRecord::Base
  attr_accessible :company_id, :warehouse_id, :plu_id, :quantity, :reference
end
