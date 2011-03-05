class User < ActiveRecord::Base
  belongs_to :role
  
  acts_as_authentic
  
  attr_accessible :username, :first_name, :last_name, :password,
                  :password_confirmation, :email
                  
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
end
