class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
    @page_subtitle = "... what's \"Articl\" in Spanish anyway?"
    @page_url = request.url

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @page_subtitle = "... not just for the country of Spain"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end
  
  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @page_subtitle = "... my cousin works for Bit.ly"
    session[:last_visited_page] = request.env['HTTP_REFERER']
    #view depends on this incase the title is cleared by user and there's an error
    @article_title = @article.title
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
    @page_subtitle = "... my cousin works for Bit.ly"
    
    #overwritten by update_attributes() (potentially blank)
    @article_title = @article.title
    
    respond_to do |format|
      if @article.update_attributes(params[:article])
        #wonder how to sync changes with the model BEFORE save
        #then I could use @article.changed?
        @article.increment!(:change_count)
        
        format.html { redirect_to(session[:last_visited_page]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
