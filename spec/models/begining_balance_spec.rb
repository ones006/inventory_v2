require 'spec_helper'

describe BeginingBalance do

  it 'should be valid with valid attributes' do
    Factory(:begining_balance).should be_valid
  end

  it 'should invalid without number' do
    Factory.build(:begining_balance, :number => nil).should_not be_valid
  end

  it 'should belongs to a company' do
    Factory(:begining_balance).company.should be_an_instance_of(Company)
  end

  it 'should have at least 1 entries' do
    Factory(:begining_balance).entries.length.should > 0
  end
end
