class StoreController < ApplicationController
  
  before_filter :find_cart, :except => :empty_cart

  #these are all actions initiated by the user
  
  def index
    
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @index_count = session[:counter]
    
    @products = Product.find_products_for_sale
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    
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
  #however, exceptions can also be raised and rescued within methods using begin/end
  rescue ActiveRecord::RecordNotFound
  #class-level access to an inner class, which exists as a class constant of ActiveRecord
    
    #is logger really an attribute?
    logger.error("Attempt to access invalid product #{params[:id]}")
    redirect_to_index(I18n.t('flash.invalid_product'))
  end
  
  def empty_cart  #only need to clear the persistent details of the cart
    session[:cart] = nil
    respond_to do |format|
      format.js if request.xhr?
      format.html { redirect_to_index(I18n.t('flash.emptied_cart')) } 
    end
  end

  def checkout
    if @cart.items.empty?
      redirect_to_index(I18n.t('flash.empty_cart'))
    else
      @order = Order.new  #only for the sake of consistency in the checkout form
    end
    
    @checkout_in_progress = true
  end
  
  def save_order
    @order = Order.new(params[:order])  #create the basic order with customer info
    #transition data from front-end model to back-end model:
    @order.add_line_items_from_cart(@cart)  #add selected items to the order
    if @order.save  #attempt to persist the model here
      session[:cart] = nil  #empty the cart
      redirect_to_index(I18n.t('flash.thanks')) #success!
    else
      @checkout_in_progress = true
      render :action => 'checkout'  #back to the order form; something was wrong
      #one action choosing to use another's view; this is different than an HTTP redirect
    end
  end
  
protected

  #override the authorize filter; this controller is now authorized automatically
  def authorize
  end
  
private
  
  def find_cart
    @cart = (session[:cart] ||= Cart.new)
  end
  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg  #think of flash as a one-time session
    redirect_to :action => 'index'
  end

end
