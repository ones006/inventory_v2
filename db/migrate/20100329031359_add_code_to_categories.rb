class AddCodeToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :code, :string
  end

  def self.down
    remove_column :categories, :code
  end
end
