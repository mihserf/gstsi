class Page < ActiveRecord::Base
  has_many :translations, :class_name => 'PageTranslation', :dependent => :destroy

  translate_columns  :name,  :content

end
