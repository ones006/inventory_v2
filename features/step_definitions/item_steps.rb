Then /^"([^\"]*)" should belongs to company "([^\"]*)"$/ do |item, company|
  item = Item.find_by_code(item)
  item.company.should == Company.find_by_subdomain(company)
end

Given /^item "([^\"]*)" exists & belongs to company "([^\"]*)"$/ do |code, company|
  Factory(:item, :code => code, :company_id => Company.find_by_subdomain(company).id)
end

Given /^category "([^\"]*)" exists$/ do |name|
  Factory(:category, :name => name)
end
