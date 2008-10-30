class TrainerExperiencesController < ApplicationController
  before_filter :get_member, :except => [:index, :destroy]
  before_filter :admin_required, :except => [:index,:show]

  def index
    @trainer_experiences = TrainerExperience.find(:all, :include => :member)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trainer_experiences }
    end
  end

  def show
  end

  def edit
    @trainer_experience = @member.trainer_experience
  end

  def update
    @trainer_experience = @member.trainer_experience
    @trainer_experience.attributes = params[:trainer_experience]
    unless params[:trainer_experience_photo].nil?
      if @trainer_experience_photo=@trainer_experience.trainer_experience_photo
        @trainer_experience_photo.update_attributes(params[:trainer_experience_photo])
      else
        @trainer_experience.create_trainer_experience_photo(params[:trainer_experience_photo])
      end
    end

    respond_to do |format|
      if @trainer_experience.save!
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
    @trainer_experience = TrainerExperience.new

  end

  def create

    @trainer_experience = TrainerExperience.new(params[:trainer_experience])

    @trainer_experience.build_trainer_experience_photo(params[:trainer_experience_photo]) unless params[:trainer_experience_photo].nil?
    @member.trainer_experience = @trainer_experience
    respond_to do |format|
      if @member.save
        flash[:notice] = 'История добавлена.'
        format.html { redirect_to members_path }
        format.xml  { render :xml => @trainer_experience, :status => :created, :location => @trainer_experience }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trainer_experience.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @trainer_experience = TrainerExperience.find(params[:id])
    @trainer_experience.destroy
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
