# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  helper_method :current_user_session, :current_user
  
  layout 'public'  #a default to be overridden in subclasses
  
  before_filter { |c| Authorization.current_user = c.current_user }
  
  filter_access_to :all
  
  #made public to support decalarative_authorization (see above)
  def current_user
    return @current_user if defined? @current_user
    @current_user = current_user_session && current_user_session.record
  end

protected

  def permission_denied
    flash[:error] = "You do not have access to #{request.path}"
    redirect_to root_url
  end
  
private

  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end

  def require_user
    unless current_user
      flash[:notice] = "You must log in first."
      redirect_to root_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      flash[:notice] = "You must log out first."
      redirect_to root_url
      return false
    end
  end
  
end
