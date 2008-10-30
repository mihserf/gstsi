class MembersController < ApplicationController
  before_filter :admin_required, :except => [:show]

  def index
    @members = Member.find(:all, :order => "last_name")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  def show
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    params[:member][:status_ids] ||= []
    @member.attributes = params[:member]

    ApplicationController.helpers.update_numbers(@member.class, params)
    
    unless params[:member_photo].nil?
      if @member_photo=@member.member_photo
        @member_photo.update_attributes(params[:member_photo])
      else
        @member.create_member_photo(params[:member_photo])
      end
    end

    respond_to do |format|
      if @member.save!
        flash[:notice] = 'Член изменён.'
        format.html { redirect_to members_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(params[:member])
    @member.build_member_photo(params[:member_photo])  unless params[:member_photo].nil?
  
    respond_to do |format|
      if (@member.save && ApplicationController.helpers.update_numbers(@member.class, params, @member.id))
        flash[:notice] = 'Член добавлен.'
        format.html { redirect_to members_path }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end

  def update_numbers(model, new_obj_id=nil)
    if params[:sortable_ids]
      albums = model.find(:all, :order => 'number ASC', :limit => 100)
      if new_obj_id
        params[:sortable_ids] = params[:sortable_ids].gsub(/new/,new_obj_id.to_s)
      end
      sortable_ids = params[:sortable_ids].split(',')
      #i=albums.size+1
      i=0
      sortable_ids =Hash[*sortable_ids.collect {|v| i+=1; [v,{'number'=>i}]}.flatten]
        model.update(sortable_ids.keys, sortable_ids.values)
    end
  end

end
