class AddLftAndRgtAndParentIdToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :parent_id, :integer
    add_column :locations, :lft, :integer
    add_column :locations, :rgt, :integer
  end

  def self.down
    remove_column :locations, :rgt
    remove_column :locations, :lft
    remove_column :locations, :parent_id
  end
end
