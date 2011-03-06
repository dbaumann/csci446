class User < ActiveRecord::Base
  belongs_to :role
  has_many :games
  
  acts_as_authentic
  
  attr_accessible :username, :first_name, :last_name, :password,
                  :password_confirmation, :email, :role_id
                  
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :role_id
  
  def to_s
    first_name + " " + last_name
  end
  
  def role_symbols
    [role.name.underscore.to_sym]
  end
  
  def is_admin?
    role_symbols.include? :admin
  end
  
  def is_member?
    role_symbols.include? :member
  end
  
end
