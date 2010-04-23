class CreateFifoTrackers < ActiveRecord::Migration
  def self.up
    create_table :fifo_trackers do |t|
      t.integer :reference_transaction_id
      t.integer :consumer_transaction_id
      t.integer :available_stock
      t.integer :quantity_consumed

      t.timestamps
    end
  end

  def self.down
    drop_table :fifo_trackers
  end
end
