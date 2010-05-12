class AddSubdomainToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :subdomain, :string

    default_company           = Company.first
    default_company.subdomain = 'monsterinc'
    default_company.save
  end

  def self.down
    remove_column :companies, :subdomain
  end
end
