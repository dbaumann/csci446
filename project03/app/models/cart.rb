class Cart  #a model that isn't mapped to the database
  
  attr_reader :items  #items is open to read
  
  def initialize      #define the setup of this object after memory allocation
    @items = []
  end
  
  def add_product(product)
    
    #look for an existing cart item containing this product; increment if found
    current_item = @items.find { |item| item.product == product }
    
    if current_item
      current_item.increment_quantity
    else
      @items << CartItem.new(product)
    end
  end
end
