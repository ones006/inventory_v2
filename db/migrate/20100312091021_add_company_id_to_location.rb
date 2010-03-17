class AddCompanyIdToLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :company_id, :integer
  end

  def self.down
    remove_column :locations, :company_id
  end
end
