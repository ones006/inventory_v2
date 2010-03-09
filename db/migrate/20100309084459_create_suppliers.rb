class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.integer :company_id
      t.string :code
      t.string :name
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :suppliers
  end
end
