class PagesController < ApplicationController
  before_filter :admin_required, :only => [:index,:new,:create,:edit,:update]

  def index
    @pages=Page.find(:all, :order => :ident_name)
    #render(:layout=>"admin")
  end

  def new
    @page=Page.new
  end

  def show
    @page=Page.find_by_ident_name(params[:id])
  end

  def create
    @page=Page.new(params[:page])
    if  @page.save!
      flash[:notice]="Страница создана. Добавте изменения в файл /config/routes.rb"
      redirect_to pages_path
    else
      render :action => "new"
    end
  end

  def edit
    @page=Page.find(params[:id])
    #render(:layout=>"admin")
  end


  def update
    @page=Page.find(params[:id])
    if  @page.update_attributes(params[:page])
      expire_fragment(:fragment => 'page1')# if params[:id].to_i==1
      flash[:notice]="страница обновлена"
      redirect_to pages_path
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end

  def home
    @page=Page.find_by_ident_name("home")
    @events = Event.find(:all, :limit => 7, :order => "created_at DESC")
    #@articles = Article.find(:all, :limit => 7, :order => "created_at DESC", :include => :magazine)
    #@success_stories = SuccessStory.find(:all, :limit => 6, :include => [:member,])
    @success_stories = SuccessStory.two_randomized
    #@projects = Project.find(:all, :limit => 5)
  end

  def about_us
    @page=Page.find_by_ident_name("about_us")
  end

  def contacts
    @page=Page.find_by_ident_name("contacts")
  end

  def faq
    @page=Page.find_by_ident_name("faq")
  end

  def charity
    @page=Page.find_by_ident_name("charity")
  end

  def founder
    @page=Page.find_by_ident_name("founder")
  end

  def team
    @page=Page.find_by_ident_name("team")
  end

  def mission
    @page=Page.find_by_ident_name("mission")
  end

  def principles
    @page=Page.find_by_ident_name("principles")
  end

  def london
    @page=Page.find_by_ident_name("london")
  end


end
