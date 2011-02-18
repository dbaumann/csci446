class Article < ActiveRecord::Base
  
  belongs_to :author
  
  cattr_reader :per_page
  @@per_page = 10
  
  validates_presence_of :title
  
  validates_presence_of :body
  
  before_save :increment_change_count
  
private
  
  def increment_change_count
    self.change_count += 1 unless self.new_record?
  end
  
end
