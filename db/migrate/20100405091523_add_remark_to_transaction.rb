class AddRemarkToTransaction < ActiveRecord::Migration
  def self.up
    add_column :transactions, :remark, :text
    rename_column :transactions, :tr_type, :transaction_ref
  end

  def self.down
    remove_column :transactions, :remark
    rename_column :transactions, :transaction_ref, :tr_type
  end
end
