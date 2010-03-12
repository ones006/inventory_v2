class AddCompanyIdToPlu < ActiveRecord::Migration
  def self.up
    add_column :plus, :company_id, :integer
  end

  def self.down
    remove_column :plus, :company_id
  end
end
