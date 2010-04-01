require File.dirname(__FILE__) + '/../spec_helper'

describe ItemTransfer do
  it "should be valid" do
    Factory(:item_transfer).should be_valid
  end

  it 'should be invalid without number' do
    Factory.build(:item_transfer, :number => nil).should_not be_valid
  end

  it 'should invalid if it have same number under a company' do
    it1 = Factory(:item_transfer)
    Factory.build(:item_transfer, :number => it1.number, :company_id => it1.company.id).should_not be_valid
  end
end
