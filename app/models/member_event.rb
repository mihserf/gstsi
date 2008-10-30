class MemberEvent < GstDb
  belongs_to :member
  has_many :translations, :class_name => 'MemberEventTranslation', :dependent => :destroy
  has_many :member_event_dates
  translate_columns :name, :description

  validates_presence_of :name
  validates_associated :member_event_dates

   include SetIdentName

  def begin_date
    member_event_dates.find(:first,:order =>"begin_date").begin_date
  end

  def end_date
    member_event_dates.find(:first,:order =>"end_date DESC").end_date
  end

end
