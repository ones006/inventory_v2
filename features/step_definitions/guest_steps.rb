Given /^I have no users$/ do
    User.delete_all
end

Then /^I should have ([0-9]+) (.+)/ do |count, model|
    model.titleize.constantize.count.should == count.to_i
end

Given /^I am not signed in$/ do
    visit signout_url
end

Given /^I have the following (.+) records$/ do |model,table|
  table.hashes.each do |u|
    Factory.create(model, u)
  end
end

Then /^I should redirected to (.+)$/ do |dest|
    visit path_to(dest)
end
