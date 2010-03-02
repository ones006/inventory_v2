require 'spec_helper'

describe Company do
  it "should create a new instance given valid attributes" do
    company = Factory.build(:company)
    company.should be_valid
  end

  it 'should be invalid without name' do
    company = Factory.build(:company, :name => nil)
    company.should_not be_valid
  end

  it 'should be invalid given name is exists' do
    Factory.create(:company, :name => 'my company')
    company = Factory.build(:company, :name => 'my company')
    company.should_not be_valid
  end
end
