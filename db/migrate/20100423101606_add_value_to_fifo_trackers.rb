class AddValueToFifoTrackers < ActiveRecord::Migration
  def self.up
    add_column :fifo_trackers, :value, :integer
  end

  def self.down
    remove_column :fifo_trackers, :value
  end
end
