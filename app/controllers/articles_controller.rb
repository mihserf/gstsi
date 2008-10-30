class ArticlesController < ApplicationController
  before_filter :admin_required, :except => [:show, :index]
  before_filter :get_magazine, :except => [:destroy]
  # GET /articles
  # GET /articles.xml
  def index
    @articles = @magazine.articles.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html { render :template => "articles/list" unless admin?}
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find_by_ident_name(params[:id]) || Article.find(params[:id])
    #@articles = Article.find_all_by_lang(@article.lang)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])
    @article.magazine_id = @magazine.id

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        format.html { redirect_to  magazine_articles_path(@magazine) }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
    @article.attributes = params[:article]

    respond_to do |format|
      if @article.save!
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to magazine_articles_path(@magazine) }
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

  def get_magazine
    @magazine = Magazine.find_by_ident_name(params[:magazine_id]) || Magazine.find(params[:magazine_id])
  end

end
