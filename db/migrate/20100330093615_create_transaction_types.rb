class CreateTransactionTypes < ActiveRecord::Migration
  def self.up
    create_table :transaction_types do |t|
      t.integer :company_id
      t.string :code
      t.text :description
      t.integer :direction, :default => 0
      t.boolean :negate, :default => false
      t.boolean :alter_date, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :transaction_types
  end
end
