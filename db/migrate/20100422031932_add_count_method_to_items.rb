class AddCountMethodToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :count_method, :string, :default => 'avg'
  end

  def self.down
    remove_column :items, :count_method
  end
end
