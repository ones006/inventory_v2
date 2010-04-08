require File.dirname(__FILE__) + '/../spec_helper'

describe Stock do

  setup do
    @company = Factory(:company)
    @stock = @company.stock
  end

  it 'should calculate item starting from the first transaction ever made' do
  end

end
