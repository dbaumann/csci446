class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      user = UserSession.find.record
      flash[:notice] = "Welcome back, #{user}."
      redirect_to root_url_by_context
    else
      flash[:error] = "Could not log in."
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
  
  def root_url_by_context
    user = UserSession.find.record
    if user.is_admin?
      admin_root_url
    elsif user.is_member?
      members_root_url
    else
      root_url
    end
  end
  
end
