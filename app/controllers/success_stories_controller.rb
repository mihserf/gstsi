class SuccessStoriesController < ApplicationController
  before_filter :get_member, :except => [:index, :destroy]
  before_filter :admin_required, :except => [:index,:show]

  def index
    @success_stories = SuccessStory.find(:all, :include => :member)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @success_stories }
    end
  end

  def show
  end

  def edit
    @success_story = @member.success_story
  end

  def update
    @success_story = @member.success_story
    @success_story.attributes = params[:success_story]
    unless params[:success_story_photo].nil?
      if @success_story_photo=@success_story.success_story_photo
        @success_story_photo.update_attributes(params[:success_story_photo])
      else
        @success_story.create_success_story_photo(params[:success_story_photo])
      end
    end
    
    respond_to do |format|
      if @success_story.save!
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
    @success_story = SuccessStory.new
    
  end

  def create
    
    @success_story = SuccessStory.new(params[:success_story])
    
    @success_story.build_success_story_photo(params[:success_story_photo]) unless params[:success_story_photo].nil?
    @member.success_story = @success_story
    respond_to do |format|
      if @member.save
        flash[:notice] = 'История добавлена.'
        format.html { redirect_to members_path }
        format.xml  { render :xml => @success_story, :status => :created, :location => @success_story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @success_story.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @success_story = SuccessStory.find(params[:id])
    @success_story.destroy
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
