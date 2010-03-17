class AddCompanyIdToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :company_id, :integer
  end

  def self.down
    remove_column :transactions, :company_id
  end
end
