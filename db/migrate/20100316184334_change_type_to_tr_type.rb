class ChangeTypeToTrType < ActiveRecord::Migration
  def self.up
    rename_column :transactions, :type, :tr_type
  end

  def self.down
    rename_column :transactions, :tr_type, :type
  end
end
