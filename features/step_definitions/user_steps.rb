Given /^I am a registered user with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
    Factory.create(:user, :username => username,:password => password)
end

Given /^I am signed in with username "([^\"]*)" & password "([^\"]*)"$/ do |username, password|
  UserSession.create(:username => username, :password => password)
end

When /^I visit subdomain "([^\"]*)"$/ do |subdomain|
    host! "#{subdomain}.test.local:3000"
end

Given /^I have tho following company records$/ do |table|
    table.hashes.each do |record|
      Factory.create(:company, :name => record[:name], :subdomain => record[:subdomain])
    end
end

Given /^the company "([^\"]*)" have user "([^\"]*)"$/ do |company, user|
  Company.find_by_name(company).users << User.find_by_username(user)
end

Given /^user "([^\"]*)" belongs to company "([^\"]*)"$/ do |user, company|
  Company.find_by_name(company).users << User.find_by_username(user)
end

Given /^I have no categories$/ do
    Category.delete_all
end

Given /^company "([^\"]*)" exists$/ do |sub|
  Factory.create(:company, :subdomain => sub)
end

Given /^user "([^\"]*)" exists$/ do |username|
  Factory.create(:user, :username => username, :password => 'secret')
end

Given /^user "([^\"]*)" is signed in on "([^\"]*)"$/ do |username, subdomain|
  steps %Q{
    Given company "#{subdomain}" exists
    Given user "#{username}" exists
    Given I visit subdomain "#{subdomain}"
  }
  company = Company.find_by_subdomain(subdomain)
  user = User.find_by_username(username)
  company.users << user
  visit signin_path
  fill_in("Username", :with => username)
  fill_in("Password", :with => 'secret')
  click_button("Sign In")
end

Then /^I should be redirected$/ do
  visit response.location
end
