class StatusesController < ApplicationController
  before_filter :admin_required, :except => [:index,:show]

  def index
      @statuses =  Status.find(:all, :order => "number")
    
    respond_to do |format|
      format.html { render :template => "statuses/list" unless admin?}
      format.xml  { render :xml => @statuses }
      format.js  { render :json => @statuses.to_json }
    end
  end

  def show
    @status = Status.find_by_ident_name(params[:id]) || Status.find(params[:id])
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    update_numbers(@status.class)
    #managing_translations(@status)
    respond_to do |format|
      #if (@status.update_attributes(params[:status]) && @status.translations.update_attributes(params[:translations]))
      if @status.update_attributes(params[:status])
        flash[:notice] = 'Член изменён.'
        format.html { redirect_to statuses_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params[:status])
    #managing_translations(@status)
    respond_to do |format|
      if (@status.save && update_numbers(@status.class, @status.id))
        flash[:notice] = 'Член добавлен.'
        format.html { redirect_to statuses_path }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end
  end

  def update_numbers(model, new_obj_id=nil)
    if params[:sortable_ids]
      albums = model.find(:all, :order => 'number DESC', :limit => 20)
      if new_obj_id
        params[:sortable_ids] = params[:sortable_ids].gsub(/new/,new_obj_id.to_s)
      end
      sortable_ids = params[:sortable_ids].split(',')
      i=albums.size+1
      sortable_ids =Hash[*sortable_ids.collect {|v| i-=1; [v,{'number'=>i}]}.flatten]
        model.update(sortable_ids.keys, sortable_ids.values)
    end
  end
  
end



