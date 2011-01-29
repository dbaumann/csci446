class Order < ActiveRecord::Base
  has_many :line_items
  
  #constant because in caps, but a constant that may be an array
  PAYMENT_TYPES = [
    #displayed      stored in db
    ["Check", "check"],
    ["Credit card", "cc"],
    ["Purchase order", "po"]
  ]
    
  validates_presence_of :name, :address, :email, :pay_type
  #what's sent for the pay_type field must have a value that's in PAYMENT_TYPES
  validates_inclusion_of :pay_type, :in =>  #in parameter is an array
    PAYMENT_TYPES.map { |disp, value| value } #map : transform an array
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item) #a kind of constructor is being called here
      line_items << li #rails will handle it from here; Order has_many line_items!
      #kind of strange, that line
    end
  end
end
