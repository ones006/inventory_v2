require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  it "should be valid given valid attributes" do
    Factory.build(:item).should be_valid
  end

  it 'should  invalid without code' do
    Factory.build(:item, :code => nil).should_not be_valid
  end

  it 'should invalid without name' do
    Factory.build(:item, :name => nil).should_not be_valid
  end

  it 'can have the same code between companies' do
    company1 = Factory(:company)
    company2 = Factory(:company)
    item1 = Factory(:item, :company_id => company1.id)
    item2 = Factory.build(:item, :code => item1.code, :company_id => company2.id)
    item2.should be_valid
  end

  it 'should have unique code within a company' do
    company = Factory(:company)
    item1 = Factory(:item, :company_id => company.id)
    Factory.build(:item, :company_id => company.id, :code => item1.code).should_not be_valid
  end

  it 'should belongs to a company' do
    Factory(:item, :company => Factory(:company)).respond_to?(:company).should be_true
  end

  it 'should belongs to a category' do
    Factory(:item, :category => Factory(:category)).respond_to?(:category).should be_true
  end

  it 'should assign category by name' do
    category = Factory(:category)
    item = Factory.create(:item, :category_id => nil, :category_name => category.name)
    item.category.should == category
  end

  it 'should invalid when category name is empty when edit' do
    item = Factory(:item)
    item.update_attributes(:category_name => nil).should be_false
  end
end
