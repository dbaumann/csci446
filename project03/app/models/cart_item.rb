class CartItem
  
  attr_reader :product, :quantity #makes it explicit that quantity is an attribute
                                  #of CartItem, and that it should be openly
                                  #readable
  
  def initialize(product)
    @product = product
    @quantity = 1
  end
  
  def increment_quantity
    @quantity += 1
  end
  
  def title
    @product.title
  end
  
  def price
    @product * @quantity
  end

end
