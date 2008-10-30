class StoriesController < ApplicationController
  before_filter :get_member, :except => [:index, :destroy]

  def index
    @stories = Story.find(:all, :order => "lang")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  def show
  end

  def edit
    @story = @member.story
  end

  def update
    @story = @member.story
    params[:story][:ident_name]=@member.ident_name+'_story'
    @story.attributes = params[:story]
    
    unless params[:story_photo].nil?
      if @story_photo=@story.story_photo
        @story_photo.update_attributes(params[:story_photo])
      else
        @story.create_story_photo(params[:story_photo])
      end
    end

    
    respond_to do |format|
      if @story.save!
        flash[:notice] = 'История изменена.'
        format.html { redirect_to members_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @city.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @story = Story.new
    
  end

  def create
    params[:story][:ident_name]=@member.ident_name+'_story'
    
    @story = Story.new(params[:story])
    @story.build_story_photo(params[:story_photo]) unless params[:story_photo].nil?
    @member.story = @story
    respond_to do |format|
      if @member.save
        flash[:notice] = 'История добавлена.'
        format.html { redirect_to members_path }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_member
    @member = Member.find(params[:member_id])
  end

end
