class Admin::GamesController < Admin::AdminController
  
  filter_resource_access
  
  def index
    @total_games = Game.count
    @games = Game.paginate :page => params[:page], :order => 'created_at DESC', :include => :user
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    @game.user = current_user
    if @game.save
      flash[:notice] = "Successfully created game."
      redirect_to admin_games_url
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:notice] = "Successfully updated game."
      redirect_to admin_games_url
    else
      render :action => 'edit'
    end
  end
end
