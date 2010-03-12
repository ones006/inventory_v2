require 'spec_helper'

describe Unit do

  it "should create a new instance given valid attributes" do
    Factory(:unit).should be_valid
  end

  it 'should be invalid without name' do
    Factory.build(:unit, :name => nil).should_not be_valid
  end

  it 'should belongs to an item' do
    Factory(:unit).item.should be_an_instance_of(Item)
  end

  it 'should have position of 1 if no unit exists for an item' do
    Factory(:unit).position.should == 1
  end

  it 'should have conversion rate of 1 if this is the first unit of an item' do
    unit = Factory(:unit, :conversion_rate => 12)
    unit.conversion_rate.should == 1
    Factory(:unit, :item_id => unit.item.id, :conversion_rate => 12).conversion_rate.should == 12
  end
end
