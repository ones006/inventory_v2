class AddAlterStockToTransactionTypes < ActiveRecord::Migration
  def self.up
    add_column :transaction_types, :alter_stock, :boolean
  end

  def self.down
    remove_column :transaction_types, :alter_stock
  end
end
