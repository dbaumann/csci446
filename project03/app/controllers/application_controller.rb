# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  #run the method authorize as a filter for all controllers in this app,
  #with the exception of the login method
  before_filter :authorize, :except => :login
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
protected
  
  def authorize
    #again using the retarded dynamic finders
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in"
      #select the admin controller and call the login action
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
    
end
