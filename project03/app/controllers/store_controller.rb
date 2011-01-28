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
  
  #remember, a rescue applies to the entire function;
  #kind of like an else, but for functions
  rescue ActiveRecord::RecordNotFound
  #class-level access to an inner class, which exists as a class constant of ActiveRecord
    
    #is logger really an attribute?
    logger.error("Attempt to access invalid product #{params[:id]}")
    flash[:notice] = "Invalid product"  #think of flash as a one-time session
    redirect_to :action => 'index'
  end
  
private
  
  def find_cart
    session[:cart] ||= Cart.new
  end

end
