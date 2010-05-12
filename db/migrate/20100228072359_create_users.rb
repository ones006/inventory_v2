class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end

    # create default user for initial login
    default_user = User.new
    default_user.username               = 'admin'
    default_user.email                  = 'admin@example.com'
    default_user.password               = 'secret'
    default_user.password_confirmation  = 'secret'
    default_user.save
  end
  
  def self.down
    drop_table :users
  end
end
