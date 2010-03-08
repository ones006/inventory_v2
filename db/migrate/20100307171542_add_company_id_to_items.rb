class AddCompanyIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :company_id, :integer
  end

  def self.down
    remove_column :items, :company_id
  end
end
