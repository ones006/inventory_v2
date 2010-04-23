class AddCompanyIdToFifoTrackers < ActiveRecord::Migration
  def self.up
    add_column :fifo_trackers, :company_id, :integer
  end

  def self.down
    remove_column :fifo_trackers, :company_id
  end
end
