class UsersController < ApplicationController

  before_filter :get_roles, :only => [:new, :edit]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      if @user.is_admin?
        redirect_to admin_root_url
      elsif @user.is_member?
        redirect_to members_root_url
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
  end
  
private

  def get_roles
    @roles = Role.all
  end

end
