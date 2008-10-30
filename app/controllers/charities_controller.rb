class CharitiesController < ApplicationController
  before_filter :admin_required, :except => [:index,:show]

  # GET /charities
  # GET /charities.xml
  def index
    @charities = Charity.find(:all, :order =>  "created_at DESC")

    respond_to do |format|
      format.html { render :template => "charities/list" unless admin?}
      format.xml  { render :xml => @charities }
    end
  end

  # GET /charities/1
  # GET /charities/1.xml
  def show
    @charity = Charity.find_by_ident_name(params[:id]) || Charity.find(params[:id])
    #@charities = Charity.find_all_by_lang(@charity.lang)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @charity }
    end
  end

  # GET /charities/new
  # GET /charities/new.xml
  def new
    @charity = Charity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @charity }
    end
  end

  # GET /charities/1/edit
  def edit
    @charity = Charity.find(params[:id])
  end

  # POST /charities
  # POST /charities.xml
  def create
    @charity = Charity.new(params[:charity])

    respond_to do |format|
      if @charity.save
        flash[:notice] = 'Charity was successfully created.'
        format.html { redirect_to charities_path }
        format.xml  { render :xml => @charity, :status => :created, :location => @charity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @charity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /charities/1
  # PUT /charities/1.xml
  def update
    @charity = Charity.find(params[:id])
    @charity.attributes = params[:charity]

    respond_to do |format|
      if @charity.save!
        flash[:notice] = 'Charity was successfully updated.'
        format.html { redirect_to(@charity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @charity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /charities/1
  # DELETE /charities/1.xml
  def destroy
    @charity = Charity.find(params[:id])
    @charity.destroy

    respond_to do |format|
      format.html { redirect_to(charities_url) }
      format.xml  { head :ok }
    end
  end
end
