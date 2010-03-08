Given /^I have no items$/ do
  Item.delete_all
end

Then /^"([^\"]*)" should belongs to company "([^\"]*)"$/ do |item, company|
  item = Item.find_by_code(item)
  item.company.should == Company.find_by_subdomain(company)
end
