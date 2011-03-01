class Gametitle:stringsController < ApplicationController
  def index
    @gametitle:strings = Gametitle:string.all
  end

  def new
    @gametitle:string = Gametitle:string.new
  end

  def create
    @gametitle:string = Gametitle:string.new(params[:gametitle:string])
    if @gametitle:string.save
      flash[:notice] = "Successfully created gametitle:string."
      redirect_to gametitle:strings_url
    else
      render :action => 'new'
    end
  end

  def edit
    @gametitle:string = Gametitle:string.find(params[:id])
  end

  def update
    @gametitle:string = Gametitle:string.find(params[:id])
    if @gametitle:string.update_attributes(params[:gametitle:string])
      flash[:notice] = "Successfully updated gametitle:string."
      redirect_to gametitle:strings_url
    else
      render :action => 'edit'
    end
  end
end
