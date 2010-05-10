class AddUsedUpToEntryDetails < ActiveRecord::Migration
  def self.up
    rename_column :entry_details, :ref_entry_id, :ref_entry_detail_id
    add_column :entry_details, :used_up, :boolean
    add_column :entry_details, :available_quantity, :integer
  end

  def self.down
    rename_column :entry_details, :ref_entry_detail_id, :ref_entry_id
    remove_column :entry_details, :used_up
    remove_column :entry_details, :available_quantity
  end
end
