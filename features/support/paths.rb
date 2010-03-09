module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    
    when /the root page/
      root_url
    
    when /the items page/
      items_url
    
    when /the administrations page/
      administrations_url
    
    when /the warehouse page/
      warehouses_url
    
    when /signin page/
      signin_url

    when /the list of suppliers/
      suppliers_path

    when /the list of categories/
      categories_path
    when /admin page/
      administrations_path
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
