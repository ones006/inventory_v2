require File.dirname(__FILE__) + '/../spec_helper'

describe TransactionType do
  it "should be valid given valid attributes" do
    Factory(:transaction_type).should be_valid
  end

  it 'should be invalid without code' do
    Factory.build(:transaction_type, :code => nil).should_not be_valid
  end

  it 'should be invalid without description' do
    Factory.build(:transaction_type, :description => nil).should_not be_valid
  end

  it 'should be invalid with the same code under a company' do
    tt1 = Factory(:transaction_type)
    Factory.build(:transaction_type, :company_id => tt1.company.id, :code => tt1.code).should_not be_valid
  end

  it 'should be invalid with the same description under a company' do
    tt1 = Factory(:transaction_type)
    Factory.build(:transaction_type, :company_id => tt1.company.id, :description => tt1.description).should_not be_valid
  end
end
