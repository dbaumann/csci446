class GamesController < ApplicationController
  def index
    @games = Game.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      flash[:notice] = "Successfully created game."
      redirect_to games_url
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
      redirect_to games_url
    else
      render :action => 'edit'
    end
  end
end
