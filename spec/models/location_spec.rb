require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  it "should create a new instance given valid attributes" do
    Factory(:location).should be_valid
  end

  it 'should be invalid without code' do
    Factory.build(:location, :code => nil).should_not be_valid
  end

  it 'should be invalid if it\'s have the same code within the same company' do
    loc = Factory(:location)
    Factory.build(:location, :company_id => loc.company_id, :warehouse_id => loc.warehouse_id, :code => loc.code).should_not be_valid
  end

  it 'should belongs to warehouse' do
    Factory(:location).warehouse.should be_an_instance_of(Warehouse)
  end

  it 'should belongs to a company' do
    Factory(:location).company.should be_an_instance_of(Company)
  end

  it 'should be root location if parent_id is blank' do
    Factory(:location, :parent_id => nil).root?.should == true
  end

  it 'should become children if parent code is valid' do
    loc1 = Factory(:location)
    loc2 = Factory(:location, :parent_code => loc1.code, :company_id => loc1.company.id)
    loc2.parent.should == loc1

  end
end
