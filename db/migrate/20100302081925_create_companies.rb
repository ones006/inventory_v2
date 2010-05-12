class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :phone

      t.timestamps
    end

    default_company       = Company.new
    default_company.name  = 'Monster Inc.'
    default_company.save
  end

  def self.down
    drop_table :companies
  end
end
