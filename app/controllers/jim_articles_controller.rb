class JimArticlesController < ApplicationController
  before_filter :admin_required, :except => [:index,:show]

  # GET /jim_articles
  # GET /jim_articles.xml
  def index
    @jim_articles = JimArticle.find(:all, :order =>  "created_at DESC")

    respond_to do |format|
      format.html { render :template => "jim_articles/list" unless admin?}
      format.xml  { render :xml => @jim_articles }
    end
  end

  # GET /jim_articles/1
  # GET /jim_articles/1.xml
  def show
    @jim_article = JimArticle.find_by_ident_name(params[:id]) || JimArticle.find(params[:id])
    #@jim_articles = JimArticle.find_all_by_lang(@jim_article.lang)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jim_article }
    end
  end

  # GET /jim_articles/new
  # GET /jim_articles/new.xml
  def new
    @jim_article = JimArticle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jim_article }
    end
  end

  # GET /jim_articles/1/edit
  def edit
    @jim_article = JimArticle.find(params[:id])
  end

  # POST /jim_articles
  # POST /jim_articles.xml
  def create
    @jim_article = JimArticle.new(params[:jim_article])

    respond_to do |format|
      if @jim_article.save
        flash[:notice] = 'JimArticle was successfully created.'
        format.html { redirect_to jim_articles_path }
        format.xml  { render :xml => @jim_article, :status => :created, :location => @jim_article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jim_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jim_articles/1
  # PUT /jim_articles/1.xml
  def update
    @jim_article = JimArticle.find(params[:id])
    @jim_article.attributes = params[:jim_article]

    respond_to do |format|
      if @jim_article.save!
        flash[:notice] = 'JimArticle was successfully updated.'
        format.html { redirect_to(@jim_article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jim_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jim_articles/1
  # DELETE /jim_articles/1.xml
  def destroy
    @jim_article = JimArticle.find(params[:id])
    @jim_article.destroy

    respond_to do |format|
      format.html { redirect_to(jim_articles_url) }
      format.xml  { head :ok }
    end
  end
end
