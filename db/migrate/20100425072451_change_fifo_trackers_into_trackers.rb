class ChangeFifoTrackersIntoTrackers < ActiveRecord::Migration
  def self.up
    add_column :fifo_trackers, :type, :string
    rename_table :fifo_trackers, :trackers
  end

  def self.down
    rename_table :trackers, :fifo_trackers
    remove_column :fifo_trackers, :type
  end
end
