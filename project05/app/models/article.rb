class Article < ActiveRecord::Base
  
  cattr_reader :per_page
  @@per_page = 10
  
  validates_presence_of :title
  
  validates_presence_of :author_name
  validate :author_is_not_sally
  
  validates_presence_of :body
  
  before_save :increment_change_count
  
private
  
  def increment_change_count
    self.change_count += 1 unless self.new_record?
  end
  
  def author_is_not_sally
    errors.add(:author_name, 'can not be Sally') if /^sally/i.match author_name
  end
  
end
