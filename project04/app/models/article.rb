class Article < ActiveRecord::Base
  
  validates_presence_of :title, :author_name, :body
  
  validate :author_is_not_sally
  
  def author_is_not_sally
    errors.add(:author_name, 'can not be Sally') if /^sally/i.match author_name
  end
  
end
