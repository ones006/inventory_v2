require 'spec_helper'

describe "/companies/new.html.erb" do
  include CompaniesHelper

  before(:each) do
    assigns[:company] = stub_model(Company,
      :new_record? => true,
      :name => "value for name",
      :address => "value for address",
      :phone => "value for phone"
    )
  end

  it "renders new company form" do
    render

    response.should have_tag("form[action=?][method=post]", companies_path) do
      with_tag("input#company_name[name=?]", "company[name]")
      with_tag("textarea#company_address[name=?]", "company[address]")
      with_tag("input#company_phone[name=?]", "company[phone]")
    end
  end
end
