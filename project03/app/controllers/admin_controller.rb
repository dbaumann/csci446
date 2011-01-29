class AdminController < ApplicationController
  
  def self.filter(controller)
    @page_title = "The Admin"
  end
  
  def login
    if request.post?  #handle the postback request
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => 'index')
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
    #otherwise, just fall through to the view, which will prompt the user for info,
    #which will be POSTed back here
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => 'login')
  end

  def index
    @total_orders = Order.count
  end

end
