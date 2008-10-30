class Training < ActiveRecord::Base
  has_many :translations, :class_name => 'TrainingTranslation', :dependent => :destroy

   translate_columns  :title,  :short_text, :body

   validates_presence_of :title, :short_text, :body

  include SetIdentName
end
