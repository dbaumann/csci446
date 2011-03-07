class Admin::UsersController < Admin::AdminController
  
  before_filter :get_roles, :only => [:new, :create, :edit, :update]
  
  filter_resource_access
  
  def index
    @users = User.paginate :page => params[:page], :order => 'last_name ASC'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to admin_users_url
    else
      flash[:error] = "Could not save profile."
      render :action => 'edit'
    end
  end
  
private

  def get_roles
    @roles = Role.all
  end
  
end
