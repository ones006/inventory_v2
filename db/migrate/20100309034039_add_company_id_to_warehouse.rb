class AddCompanyIdToWarehouse < ActiveRecord::Migration
  def self.up
    add_column :warehouses, :company_id, :integer
  end

  def self.down
    remove_column :warehouses, :company_id
  end
end
