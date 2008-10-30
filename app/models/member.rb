class Member < GstDb
  has_many :member_statuses, :dependent => :destroy
  has_many :statuses, :through => :member_statuses, :dependent => :destroy
  has_many :translations, :class_name => 'MemberTranslation', :dependent => :destroy
  has_many :member_events
  has_one :member_photo, :dependent => :destroy
  has_one :success_story, :dependent => :destroy
  has_one :story, :dependent => :destroy
  has_one :opinion, :dependent => :destroy
  has_one :trainer_experience, :dependent => :destroy
  belongs_to :city
  translate_columns  :first_name, :last_name, :middle_name, :status

  named_scope :with_opinion, :joins =>:opinion
  named_scope :with_events, :include =>:member_events

  validates_presence_of :first_name, :last_name

  include SetIdentName

  def name
    last_name+" "+first_name.first
  end

  def name_view
    first_name+" "+last_name.first
  end

  def has_current_schedule?
    beginning_of_current_month = Date.today().beginning_of_month
    !member_events.find(:all, :include => :member_event_dates, :order =>"member_event_dates.begin_date ASC", :conditions => "member_event_dates.begin_date >= '#{beginning_of_current_month}'").empty?
  end

  
end
