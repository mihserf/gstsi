class SuccessStory < GstDb
  belongs_to :member
  has_one :success_story_photo
  has_many :translations, :class_name => 'SuccessStoryTranslation', :dependent => :destroy

  translate_columns  :title, :short_text, :body

  validates_presence_of  :short_text

  def self.two_randomized
    [find(:all).select_rotated(1),find(:all).select_rotated(2)]
  end

end
