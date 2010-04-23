class AddItemIdAndClosedToFifoTrackers < ActiveRecord::Migration
  def self.up
    add_column :fifo_trackers, :item_id, :integer
    add_column :fifo_trackers, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :fifo_trackers, :closed
    remove_column :fifo_trackers, :item_id
  end
end
