class AddCodeToPlus < ActiveRecord::Migration
  def self.up
    add_column :plus, :code, :string
  end

  def self.down
    remove_column :plus, :code
  end
end
