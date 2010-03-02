require 'spec_helper'

describe "/companies/edit.html.erb" do
  include CompaniesHelper

  before(:each) do
    assigns[:company] = @company = stub_model(Company,
      :new_record? => false,
      :name => "value for name",
      :address => "value for address",
      :phone => "value for phone"
    )
  end

  it "renders the edit company form" do
    render

    response.should have_tag("form[action=#{company_path(@company)}][method=post]") do
      with_tag('input#company_name[name=?]', "company[name]")
      with_tag('textarea#company_address[name=?]', "company[address]")
      with_tag('input#company_phone[name=?]', "company[phone]")
    end
  end
end
