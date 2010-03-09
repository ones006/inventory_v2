Given /^I have no (.+)s?$/ do |model|
  model.singularize.titleize.constantize.delete_all
end
