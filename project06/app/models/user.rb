class User < ActiveRecord::Base
  belongs_to :role
  has_many :games
  
  #this only works some of the time
  has_attached_file :photo,
                    :styles => { :thumbnail => ["150x150", :png] },
                    :url => '/assets/:class/:attachment/:id/:style/:filename'
  
  acts_as_authentic
  
  validates_length_of :username, :minimum => 6
  validates_uniqueness_of :username
  
  validates_length_of :password, :minimum => 6
  
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
