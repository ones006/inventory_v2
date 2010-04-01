class AddDefaultToWarehouse < ActiveRecord::Migration
  def self.up
    add_column :warehouses, :default, :boolean
  end

  def self.down
    remove_column :warehouses, :default
  end
end
