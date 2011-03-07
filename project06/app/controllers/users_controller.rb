class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = get_member_role
    if @user.save
      flash[:notice] = "Welcome, #{@user}."
      if @user.is_admin?
        redirect_to admin_root_url
      elsif @user.is_member?
        redirect_to members_root_url
      else
        redirect_to root_url
      end
    else
      flash[:error] = "Sorry, could not register you."
      render :action => 'new'
    end
  end
  
private

  def get_member_role
    Role.find_by_name('Member')
  end

end
