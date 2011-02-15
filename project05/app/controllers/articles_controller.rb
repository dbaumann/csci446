class ArticlesController < ApplicationController
  
  before_filter :set_edit_return_url, :only => [:edit]
  before_filter :preserve_article_title, :only => [:edit, :update]
  
  # GET /articles
  def index
    @articles = Article.paginate :page => params[:page], :order => 'created_at ASC'
  end

  # GET /articles/new
  def new
    @article = Article.new
  end
  
  # POST /articles
  def create
    @article = Article.new(params[:article])

    if @article.save
      redirect_to(@article, :flash => { :success => 'Article was successfully created.' })
    else
      flash[:error] = "Article could not be saved."
      render :action => "new"
    end
    
  end
  
  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    @page_url = request.url
  end

  # GET /articles/1/edit
  def edit
    @article ||= Article.find(params[:id])
  end

  # PUT /articles/1
  def update
    @article ||= Article.find(params[:id])
    
    if @article.update_attributes(params[:article])
      redirect_to(session[:last_visited_page], :flash => { :success => 'Changes to article have been saved.' })
    else
      flash[:error] = "Changes could not be saved."
      render :action => "edit"
    end

  end

  # DELETE /articles/1
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to(articles_url, :flash => { :success => 'Article deleted.' })
  end
  
  
private

  def set_edit_return_url
    session[:last_visited_page] = request.referer
  end
  
  def preserve_article_title
    @article = Article.find(params[:id])
    #view depends on this incase the title is cleared by user and there's an error
    @article_title = @article.title
  end
end
