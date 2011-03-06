class GamesController < ApplicationController
  def index
    @games = Game.paginate :page => params[:page], :order => 'created_at DESC'
  end
end
