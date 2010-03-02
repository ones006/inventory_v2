require 'spec_helper'

describe "/companies/index.html.erb" do
  include CompaniesHelper

  before(:each) do
    assigns[:companies] = [
      stub_model(Company,
        :name => "value for name",
        :address => "value for address",
        :phone => "value for phone"
      ),
      stub_model(Company,
        :name => "value for name",
        :address => "value for address",
        :phone => "value for phone"
      )
    ]
  end

  it "renders a list of companies" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for address".to_s, 2)
    response.should have_tag("tr>td", "value for phone".to_s, 2)
  end
end
