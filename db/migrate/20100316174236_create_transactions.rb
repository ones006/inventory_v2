class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :number
      t.integer :origin_id
      t.integer :destination_id
      t.integer :quantity
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
