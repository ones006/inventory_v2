class AddValueToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :value, :integer
  end

  def self.down
    remove_column :entries, :value
  end
end
