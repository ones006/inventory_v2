class Location < ActiveRecord::Base
  belongs_to :warehouse
  belongs_to :company
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :company_id
end
