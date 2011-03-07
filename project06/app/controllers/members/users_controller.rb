class Members::UsersController < Members::MembersController
  
  before_filter :prep_user
  
  #must use filter_resource_access;
  #using filter_access_to causes other bigger problems
  filter_resource_access
  
  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated profile."
      redirect_to members_root_url
    else
      flash[:error] = "Could not save profile."
      render :action => 'edit'
    end
  end
  
private

  def prep_user
    #a workaround for the stupidity of declarative_authorization
    params[:id] = current_user.id
  end
  
end
