class Author < ActiveRecord::Base
  
  has_many :articles
  
  has_attached_file :photo,
                    :styles => { :thumbnail => ["150x150", :png] },
                    :url => '/assets/:class/:attachment/:id/:style/:filename'
  
  cattr_reader :per_page
  @@per_page = 10
  
  validates_presence_of :name

  validate :author_is_not_sally

  def to_s
    name
  end
  
private
  
  def author_is_not_sally
    errors.add(:name, 'can not be Sally') if /^sally/i.match name
  end  
    
end
