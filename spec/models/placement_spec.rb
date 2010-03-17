require File.dirname(__FILE__) + '/../spec_helper'

describe Placement do
  it "should be valid" do
    Placement.new.should be_valid
  end
end
