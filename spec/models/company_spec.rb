require File.dirname(__FILE__) + '/../spec_helper'

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

  it 'should have sorted list of categories' do
    company = Factory(:company)
    root = Factory(:category, :company_id => company.id)
    child1 = Factory(:category, :company_id => company.id)
    child1.move_to_child_of root
    child2 = Factory(:category, :company_id => company.id)
    child2.move_to_child_of root
    child1_child = Factory(:category, :company_id => company.id)
    child1_child.move_to_child_of child1
    Company.first.sorted_categories.should == [root, child1, child1_child, child2]
  end
end
