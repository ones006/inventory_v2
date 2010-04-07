class AddAlterStockToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :alter_stock, :boolean, :default => true
  end

  def self.down
    remove_column :transactions, :alter_stock
  end
end
