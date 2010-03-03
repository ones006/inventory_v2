Given /^I am a registered user with username "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
    Factory.create(:user, :username => username,:password => password)
end

When /^I visit subdomain "([^\"]*)"$/ do |subdomain|
    host! "#{subdomain}.test.local"
    visit root_url
end

Given /^I have tho following company records$/ do |table|
    table.hashes.each do |record|
      Factory.create(:company, :name => record[:name], :subdomain => record[:subdomain])
    end
end

Given /^the company "([^\"]*)" have user "([^\"]*)"$/ do |company, user|
  Company.find_by_name(company).users << User.find_by_username(user)
end
