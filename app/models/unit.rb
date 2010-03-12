class Unit < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :name, :message => "unit name can't be blank"
  validates_presence_of :conversion_rate, :message => "convertion rate can't be blank"
  validates_numericality_of :conversion_rate, :message => "conversion_rate must be number", :allow_blank => true

  after_create :assign_position
  after_create :assign_default_conversion_rate

  private
  def assign_position
    self.update_attributes(:position => self.item.units.length)
  end

  def assign_default_conversion_rate
    self.update_attributes(:conversion_rate => 1) if self.item.units.length == 1
  end
end
