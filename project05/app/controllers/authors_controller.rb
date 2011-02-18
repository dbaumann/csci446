class AuthorsController < ApplicationController
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
      redirect_to(@author, :success => 'Author was successfully created.')
    else
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
      redirect_to(@author, :success => 'Author was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /authors/1
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    redirect_to(authors_url)
  end
end
