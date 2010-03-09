require File.dirname(__FILE__) + '/../spec_helper'

describe Supplier do
  it "should be valid" do
    Factory.build(:supplier).should be_valid
  end

  it 'should belongs to a company' do
    Factory(:supplier).company.should be_an_instance_of(Company)
  end

  it 'should be invalid without code' do
    Factory.build(:supplier, :code => nil).should_not be_valid
  end

  it 'should be invalid without name' do
    Factory.build(:supplier, :name => nil).should_not be_valid
  end

  it 'should have unique code within the same company' do
    supp1 = Factory(:supplier)
    supp2 = Factory.build(:supplier, :company_id => supp1.company.id, :code => supp1.code).should_not be_valid
  end

end
