class Product < ActiveRecord::Base
  
  has_many :line_items
  has_many :orders, :through => :line_items
  
  
  #these look like method calls outside of a method definition
  validates_presence_of :title, :description, :image_url
  
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  
  validates_uniqueness_of :title
  
  #what if this was an uploaded file? could we validate the binary data?
  validates_format_of :image_url,
                      :with => %r{\.(gif|jpg|png)$}i, #regex in case-insensitive mode
                      #what about for an email address?
                      :message => "must be a URL for GIF, JPG, or PNG image"
  
  validates_length_of :title, :minimum => 10,
                    :message => "your product description must be atleast 10 " +
                      "characters long."
                      
  def self.find_products_for_sale
    #all matching rows as opposed to a certain number of them, ordered by title
    find(:all, :order => 'title')
    #don't need to specify the context for find; it's the product ofcourse
    #one benefit of having the model code in a class that extends the ORM
  end

protected

  #the specification of a business rule in plain english
  #another reason why validation belongs in the model: validations are often
  #business rules, and business rules are enforced in the model
  def price_must_be_at_least_a_cent
    errors.add(:price, 'should be atleast 0.01') if price.nil? or price < 0.01
  end
  
end
