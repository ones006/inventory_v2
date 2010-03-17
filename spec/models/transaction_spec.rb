require 'spec_helper'

describe Transaction do
  before(:each) do
    @valid_attributes = {
      :number => "value for number",
      :origin_id => 1,
      :destination_id => 1,
      :quantity => 1,
      :type => "value for type"
    }
  end

  it "should create a new instance given valid attributes" do
    Transaction.create!(@valid_attributes)
  end
end
