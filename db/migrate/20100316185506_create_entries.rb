class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :company_id
      t.integer :transaction_id
      t.integer :plu_id
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
