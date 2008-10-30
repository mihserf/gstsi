class MemberEventsController < ApplicationController
  before_filter :get_member
  before_filter :admin_required, :except => [:index,:show]

  def index
    beginning_of_current_month = Date.today().beginning_of_month
    beginning_of_2_months_ago = Date.today().months_ago(2)
    date_cond = admin? ?  beginning_of_2_months_ago : beginning_of_current_month
    @member_events = @member.member_events.find(:all, :include => :member_event_dates, :order =>"member_event_dates.begin_date ASC", :conditions => "member_event_dates.begin_date >= '#{date_cond}'")

    respond_to do |format|
      format.html { render :template => "member_events/list" unless admin?}
      format.xml  { render :xml => @member_events }
    end
  end

  def show
  end

  def edit
    @member_event = MemberEvent.find(params[:id])
  end

  def update
    @member_event = MemberEvent.find(params[:id])
    @member_event.attributes = params[:member_event]
    managing_dates
    
    respond_to do |format|
      if @member_event.save!
        flash[:notice] = 'Событие  изменено.'
        format.html { redirect_to member_member_events_path(@member) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @member_event = MemberEvent.new
  end

  def create
    @member_event = MemberEvent.new(params[:member_event])
    @member_event.member_id = @member.id
     managing_dates
    respond_to do |format|
      if @member_event.save!
        flash[:notice] = 'Событие добавлено.'
        format.html { redirect_to member_member_events_path(@member) }
        format.xml  { render :xml => @member_event, :status => :created, :location => @member_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @member_event = MemberEvent.find(params[:id])
    @member_event.destroy
    respond_to do |format|
      format.html { redirect_to(member_member_events_path(@member)) }
      format.xml  { head :ok }
    end
  end

  def managing_dates
    params[:member_event_dates] ||= []
    params[:member_event_dates].each do |date|
      @member_event.member_event_dates.build(date)
    end
    
    params[:existing_member_event_dates] ||= []
    MemberEventDate.update(params[:existing_member_event_dates].keys, params[:existing_member_event_dates].values) unless params[:existing_member_event_dates].empty?
  end

  private

  def get_member
    @member = Member.find(params[:member_id])
  end
  
end
