require 'spec_helper'

describe "/companies/show.html.erb" do
  include CompaniesHelper
  before(:each) do
    assigns[:company] = @company = stub_model(Company,
      :name => "value for name",
      :address => "value for address",
      :phone => "value for phone"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ address/)
    response.should have_text(/value\ for\ phone/)
  end
end
