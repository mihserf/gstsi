class MagazinesController < ApplicationController
  before_filter :admin_required, :except => [:index,:show]

  # GET /magazines
  # GET /magazines.xml
  def index
    @magazines = Magazine.find(:all, :order => :ident_name)

    respond_to do |format|
      format.html { render :template => "magazines/list" unless admin?}
      format.xml  { render :xml => @magazines }
    end
  end

  # GET /magazines/1
  # GET /magazines/1.xml
  def show
    @magazine = Magazine.find_by_ident_name(params[:id]) || Magazine.find(params[:id])
    #@magazines = Magazine.find_all_by_lang(@magazine.lang)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @magazine }
    end
  end

  # GET /magazines/new
  # GET /magazines/new.xml
  def new
    @magazine = Magazine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @magazine }
    end
  end

  # GET /magazines/1/edit
  def edit
    @magazine = Magazine.find(params[:id])
  end

  # POST /magazines
  # POST /magazines.xml
  def create
    @magazine = Magazine.new(params[:magazine])
    @magazine.build_logo(params[:magazine_logo]) unless params[:magazine_logo].nil?
    respond_to do |format|
      if @magazine.save
        flash[:notice] = 'Magazine was successfully created.'
        format.html { redirect_to magazines_path }
        format.xml  { render :xml => @magazine, :status => :created, :location => @magazine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @magazine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /magazines/1
  # PUT /magazines/1.xml
  def update
    @magazine = Magazine.find(params[:id])
    @magazine.attributes = params[:magazine]

    unless params[:magazine_logo].nil?
      if @magazine_logo = @magazine.logo
        @magazine_logo.update_attributes(params[:magazine_logo])
      else
        @magazine.create_logo(params[:magazine_logo])
      end
    end

    respond_to do |format|
      if @magazine.save!
        flash[:notice] = 'Magazine was successfully updated.'
        format.html { redirect_to(@magazine) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @magazine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /magazines/1
  # DELETE /magazines/1.xml
  def destroy
    @magazine = Magazine.find(params[:id])
    @magazine.destroy

    respond_to do |format|
      format.html { redirect_to(magazines_url) }
      format.xml  { head :ok }
    end
  end
end
