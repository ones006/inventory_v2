Given /^warehouse "([^\"]*)" exists$/ do |code|
  Factory(:warehouse, :code => code) if Warehouse.find_by_code(code).nil?
end

Given /^warehouse "([^\"]*)" belongs to company "([^\"]*)"$/ do |warehouse, company|
  steps %Q{
    Given warehouse "#{warehouse}" exists
    Given company "#{company}" exists
  }
  Warehouse.find_by_code(warehouse).update_attributes(:company_id => Company.find_by_subdomain(company).id)
end
