class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation
  belongs_to :company
end
