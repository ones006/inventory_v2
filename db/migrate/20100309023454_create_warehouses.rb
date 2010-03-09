class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.string :code
      t.string :name
      t.text :address
      t.timestamps
    end
  end
  
  def self.down
    drop_table :warehouses
  end
end
