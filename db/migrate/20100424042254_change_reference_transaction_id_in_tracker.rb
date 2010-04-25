class ChangeReferenceTransactionIdInTracker < ActiveRecord::Migration
  def self.up
    rename_column :fifo_trackers, :reference_transaction_id, :stock_entry_id
    rename_column :fifo_trackers, :consumer_transaction_id, :consumer_entry_id
    rename_column :fifo_trackers, :quantity_consumed, :consumed_stock
  end

  def self.down
    rename_column :fifo_trackers, :stock_entry_id, :reference_transaction_id
    rename_column :fifo_trackers, :consumer_entry_id, :consumer_transaction_id
    rename_column :fifo_trackers, :consumed_stock, :quantity_consumed
  end
end
