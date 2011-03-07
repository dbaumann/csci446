class GamesController < ApplicationController
  def index
    @games = Game.paginate :page => params[:page], :order => 'created_at DESC', :include => :user
    render :layout => get_layout
  end
  
private

  def get_layout
    unless current_user.blank?
      if current_user.is_admin?
        'admin'
      elsif current_user.is_member?
        'members'
      else
        'public'
      end
    end
  end

end
