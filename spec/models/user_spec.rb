require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should be valid with correct attributes" do
    user = Factory.build(:user)
    user.should be_valid
  end
end
