class AddNameToTransactionTypes < ActiveRecord::Migration
  def self.up
    add_column :transaction_types, :name, :string
  end

  def self.down
    remove_column :transaction_types, :name
  end
end
