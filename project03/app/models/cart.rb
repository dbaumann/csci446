class Cart  #a model that isn't mapped to the database
  
  attr_reader :items  #items is open to read
  
  def initialize      #define the setup of this object after memory allocation
    @items = []
  end
  
  def add_product(product)
    @items << product
  end
end
