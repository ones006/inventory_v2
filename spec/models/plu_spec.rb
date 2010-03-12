require File.dirname(__FILE__) + '/../spec_helper'

describe Plu do
  it "should be valid" do
    Factory(:plu).should be_valid
  end

  it 'should be invalid without code' do
    Factory.build(:plu, :code => nil).should_not be_valid
  end

  it 'should be invalid without item_id' do
    Factory.build(:plu, :item_id => nil).should_not be_valid
  end

  it 'should be invalid without supplier_id' do
    Factory.build(:plu, :supplier_id => nil).should_not be_valid
  end

  it 'should be invalid without payment_term' do
    Factory.build(:plu, :payment_term => nil).should_not be_valid
  end

  it 'should have unique code within a company' do
    plu1 = Factory(:plu)
    Factory.build(:plu, :company_id => plu1.company_id, :code => plu1.code).should_not be_valid
  end
end

