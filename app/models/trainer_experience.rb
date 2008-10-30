class TrainerExperience < GstDb
  belongs_to :member
  has_many :translations, :class_name => 'TrainerExperienceTranslation', :dependent => :destroy

  translate_columns  :title, :short_text, :body

  validates_presence_of  :body
end
