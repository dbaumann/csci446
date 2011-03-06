class Admin::AdminController < ApplicationController

  before_filter :require_user
  
  layout 'admin'
  
  
  def index
    redirect_to admin_games_url
  end
  
protected

  def permission_denied
    flash[:error] = "You do not have access to #{request.path}"
    redirect_to admin_root_url
  end
  
end
