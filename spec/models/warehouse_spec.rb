require File.dirname(__FILE__) + '/../spec_helper'

describe Warehouse do
  it "should be valid" do
    Factory.build(:warehouse).should be_valid
  end

  it 'should be invalid without code' do
    Factory.build(:warehouse, :code => nil).should_not be_valid
  end

  it 'should be invalid without name' do
    Factory.build(:warehouse, :name => nil).should_not be_valid
  end

  it 'should have unique code within a company' do
    company = Factory(:company)
    w1 = Factory(:warehouse, :company_id => company.id, :code => "WH#1")
    Factory.build(:warehouse, :company_id => company.id, :code => "WH#1").should_not be_valid
  end
end
