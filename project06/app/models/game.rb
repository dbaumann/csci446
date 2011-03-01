class Game < ActiveRecord::Base
  attr_accessible :title, :rating
  
  cattr_reader :per_page
  @@per_page = 5
end
