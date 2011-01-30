# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  #run the method authorize as a filter for all controllers in this app,
  #with the exception of the login method
  before_filter :authorize, :except => :login
  before_filter :set_locale
  
  #define the default layout for all controllers
  layout 'store' #can't use a Symbol here; interesting
  
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
  
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale

    locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"

    unless I18n.load_path.include? locale_path
      I18n.load_path << locale_path
      I18n.backend.send(:init_translations)
    end

  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#{I18n.locale} translation not available"

    I18n.load_path -= [locale_path]
    I18n.locale = session[:locale] = I18n.default_locale
  end
    
end
