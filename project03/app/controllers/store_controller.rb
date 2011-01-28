class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    
    #this is to add a PRODUCT; the controller doesn't care about
    #how the cart deals with the items it's been given
    @cart.add_product(product)
  end
  
private
  
  def find_cart
    session[:cart] ||= Cart.new
  end

end
