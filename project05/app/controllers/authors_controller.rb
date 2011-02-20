class AuthorsController < ApplicationController
  
  before_filter :set_edit_return_url, :only => [:edit]
  
  # GET /authors
  def index
    @authors = Author.paginate :page => params[:page], :order => 'created_at ASC'
  end
  
  # GET /authors/new
  def new
    @author = Author.new
  end
  
  # POST /authors
  def create
    @author = Author.new(params[:author])

    if @author.save
      redirect_to(@author, :flash => { :success => 'Author was successfully created.' })
    else
      flash.now[:error] = "Author could not be saved."
      render :action => "new"
    end
  end

  # GET /authors/1
  def show
    @author = Author.find(params[:id])
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # PUT /authors/1
  def update
    @author = Author.find(params[:id])

    if @author.update_attributes(params[:author])
      redirect_to(@author, :flash => { :success => 'Changes to article have been saved.' })
    else
      flash.now[:error] = "Changes could not be saved."
      render :action => "edit"
    end
  end

  # DELETE /authors/1
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    redirect_to(authors_url, :flash => { :success => 'Author deleted.' })
  end
  
private
  
  def set_edit_return_url
    session[:last_visited_page] = request.referer
  end
end
