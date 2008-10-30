class Story < GstDb
  belongs_to :member
  has_one :story_photo
  has_many :translations, :class_name => 'StoryTranslation', :dependent => :destroy

  translate_columns  :title, :short_text, :body

  validates_presence_of :short_text, :body

end
