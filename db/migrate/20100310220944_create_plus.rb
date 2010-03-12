class CreatePlus < ActiveRecord::Migration
  def self.up
    create_table :plus do |t|
      t.integer :item_id
      t.integer :supplier_id
      t.string :payment_term
      t.timestamps
    end
  end
  
  def self.down
    drop_table :plus
  end
end
