require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  it "should be valid" do
    category = Factory.build(:category)
    category.should be_valid
  end

  it 'should invalid without a name' do
    category = Factory.build(:category, :name => nil)
    category.should_not be_valid
  end

  it 'should belongs to a company' do
    company = Factory.create(:company)
    category = Factory.create(:category, :company => company)
    category.company.should == company
  end

  it 'should have unique name within a company' do
    category = Factory.create(:category, :name => "test cat", :company_id => 1, :parent_name => nil)
    category2 = Factory.build(:category, :name => "test cat", :company_id => 1, :parent_name => nil)
    category2.should_not be_valid
  end

  it 'can have same name in different company' do
    comp1 = Factory.create(:company)
    comp2 = Factory.create(:company)
    cat1 = Factory.create(:category, :company => comp1, :name => "Foo Bar")
    cat2 = Factory.create(:category, :company => comp2, :name => "Foo Bar")
    cat2.should be_valid
  end

  it 'should be able to have children' do
    cat1 = Factory.create(:category)
    child_cat = Factory.create(:category)
    child_cat.move_to_child_of(cat1)
    cat1.children.length.should == 1
    child_cat.parent.should == cat1
  end

  it 'should become root if parent category name is empty' do
    cat1 = Factory(:category)
    cat1.root?.should be_true
  end

  it 'should become root if parent category name is emptied when editing' do
    cat1 = Factory(:category)
    cat2 = Factory(:category)
    cat2.move_to_child_of cat1
    cat2.update_attributes(:parent_name => nil)
    cat2.root?.should be_true
  end
end
