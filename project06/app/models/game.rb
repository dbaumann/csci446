class Game < ActiveRecord::Base
  attr_accessible :title, :rating
  
  cattr_reader :per_page
  @@per_page = 10
  
  validates_presence_of :title
  validates_presence_of :rating
  
  validate :rating_is_within_range
  
  def rating_name
    ratings = ["Horrible", "Meh.", "Good", "Amazing"]
    ratings[rating-1] #indexed from 1 in the database
  end
  
private

  def rating_is_within_range
    errors.add(:rating, 'must be between 1 and 5') if not 1..5 === rating
  end
end
