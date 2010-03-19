require 'spec_helper'

describe Entry do

  it "should create a new instance given valid attributes" do
    Factory(:entry).should be_valid
  end

  it 'should invalid without quantity' do
    Factory.build(:entry, :quantity => nil).should_not be_valid
  end
end
