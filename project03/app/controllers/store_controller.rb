class StoreController < ApplicationController
  
  #these are all actions initiated by the user
  
  def index
    
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @index_count = session[:counter]
    
    @products = Product.find_products_for_sale
    
    @cart = find_cart
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    
    #this is to add a PRODUCT; the controller doesn't care about
    #how the cart deals with the items it's been given
    @current_item = @cart.add_product(product)
    
    #add action assumed to be successful at this point; reset the count
    session[:counter] = 0
    
    #now the ajax helper method instead
    respond_to do |format| 
      #respond_to yields a format, on which a format method can be called
      format.js if request.xhr?
      format.html { redirect_to_index } #pass a block to the html format method
    end
  
  #remember, a rescue applies to the entire function;
  #kind of like an else, but for functions
  rescue ActiveRecord::RecordNotFound
  #class-level access to an inner class, which exists as a class constant of ActiveRecord
    
    #is logger really an attribute?
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index("Invalid product")
  end
  
  def empty_cart  #only need to clear the persistent details of the cart
    session[:cart] = nil
    respond_to do |format|
      format.js if request.xhr?
      format.html { redirect_to_index }
    end
  end
    
  
private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg  #think of flash as a one-time session
    redirect_to :action => 'index'
  end

end
