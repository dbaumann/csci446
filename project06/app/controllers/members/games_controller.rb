class Members::GamesController < Members::MembersController
  
  filter_resource_access
  
  def index
    @games = Game.paginate :page => params[:page], :conditions => ['user_id = ?', current_user.id], :order => 'created_at DESC', :include => :user
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    @game.user = current_user
    if @game.save
      flash[:notice] = "Successfully added #{@game}."
      redirect_to members_games_url
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
      redirect_to members_games_url
    else
      flash[:error] = "Could not save changes."
      render :action => 'edit'
    end
  end
  
end
