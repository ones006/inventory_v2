class AddCompanyIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company_id, :integer

    # associate the first user to default company
    default_user    = User.first
    default_company = Company.first
    default_user.company = default_company
    default_user.save
  end

  def self.down
    remove_column :users, :company_id
  end
end
