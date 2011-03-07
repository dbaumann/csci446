class Admin::GamesController < Admin::AdminController
  
  before_filter :get_users, :only => [:new, :create, :edit, :update]
  
  filter_resource_access
  
  def index
    @total_games = Game.count
    @games = Game.paginate :page => params[:page], :order => 'created_at DESC', :include => :user
  end

  def new
    @game = Game.new
    @game.user = current_user
  end

  def create
    @game = Game.new()  #not clear why this can't handle the user_id field
    if @game.update_attributes(params[:game])
      flash[:notice] = "Successfully added #{@game}."
      redirect_to admin_games_url
    else
      flash[:error] = "Could not create game."
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:notice] = "Successfully updated #{@game}."
      redirect_to admin_games_url
    else
      flash[:error] = "Could not save changes."
      render :action => 'edit'
    end
  end
  
private

  def get_users
    @users = User.all
  end
  
end
