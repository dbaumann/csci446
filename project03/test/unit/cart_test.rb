require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products
  
  def setup
    @cart = Cart.new
    @ruby_book = products(:ruby_book)
    @rails_book = products(:rails_book)
  end
  
  test "add unique products" do
    @cart.add_product @ruby_book
    @cart.add_product @rails_book
    
    assert_equal 2, @cart.items.size
    assert_equal @ruby_book.price + @rails_book.price, @cart.total_price
  end
  
  test "add duplicate product" do
    @cart.add_product @rails_book
    @cart.add_product @rails_book
    assert_equal 2*@rails_book.price, @cart.total_price
    assert_equal 1, @cart.items.size
    assert_equal 2, @cart.items[0].quantity
  end
end
