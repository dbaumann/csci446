class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li #return the value
    
    #The transition of data from one model to another ought to be explicit.
    #These are two distinct concepts; trying to make the above code more generic
    #would only cause problems as the two models inevitably diverge.
    
    #If they truly represent the same ideas, then they should be consolidated into a single
    #model. Remember: Simplest thing that could work. Don't get fancy unless the situation
    #calls for it.
  end
end
