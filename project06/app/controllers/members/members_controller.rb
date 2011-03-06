class Members::MembersController < ApplicationController

  before_filter :require_user
  
  layout 'members'
  
  
  def index
    redirect_to members_games_url
  end
  
protected

  def permission_denied
    flash[:error] = "You do not have access to #{request.path}"
    redirect_to members_root_url
  end
  
end
