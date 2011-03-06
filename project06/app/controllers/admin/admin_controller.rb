class Admin::AdminController < ApplicationController

  #before_filter :require_user
  
  #filter_access_to :all
  
  layout 'admin'
  
  
  def index
    
  end
  
protected

  def permission_denied
    flash[:error] = "You do not have access to #{request.path}"
    redirect_to admin_root_url
  end
  
end
