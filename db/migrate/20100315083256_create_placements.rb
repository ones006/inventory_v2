class CreatePlacements < ActiveRecord::Migration
  def self.up
    create_table :placements do |t|
      t.integer :company_id
      t.integer :warehouse_id
      t.integer :plu_id
      t.integer :quantity
      t.string :reference
      t.timestamps
    end
  end
  
  def self.down
    drop_table :placements
  end
end
