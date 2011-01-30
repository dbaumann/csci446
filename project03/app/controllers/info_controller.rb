class InfoController < ApplicationController
  
  def who_bought
    #DON'T use local variables; use instance variables so that related function calls
    #can rely on the scope in which the process is occuring instead of passed-in variables;
    #interfaces like that tend to cause coupling nightmares.
    @product = Product.find(params[:id])
    @orders = @product.orders
    
    respond_to do |format|
      format.html
      #the following format would be determined from the HTTP Accept header, which would probably be set to application/xml for requests to this endpoint.
      format.xml { render :layout => false }  #don't worry about calling the conventional view
      format.atom { render :layout => false }
      #a quick way to respond to an AJAX call:
      format.json { render :layout => false,
                           :json => @product.to_json(:include => :orders) }
    end
  rescue ActiveRecord::RecordNotFound
    render :status => 404, :layout => false
  end
  
  def who_bought_automation
    #must be an exact match to find_by; regex not allowed with dynamic finders
    @product = Product.find_by_title('Pragmatic Project Automation')  
    @orders = @product.orders
    
    respond_to do |format|
      format.xml { render :layout => false,
                          :xml => @product.to_xml(:include => :orders) }
    end
  rescue ActiveRecord::RecordNotFound
    render :status => 404, :layout => false
  end
  
protected

  def authorize
  end

end
