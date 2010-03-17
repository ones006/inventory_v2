require 'spec_helper'

describe Entry do
  before(:each) do
    @valid_attributes = {
      :company_id => 1,
      :transaction_id => 1,
      :plu_id => 1,
      :quantity => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Entry.create!(@valid_attributes)
  end
end
