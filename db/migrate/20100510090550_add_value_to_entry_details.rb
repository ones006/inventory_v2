class AddValueToEntryDetails < ActiveRecord::Migration
  def self.up
    add_column :entry_details, :value, :integer
  end

  def self.down
    remove_column :entry_details, :value
  end
end
