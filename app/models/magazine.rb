class Magazine < GstDb
  has_one :logo, :class_name => 'MagazineLogo',  :dependent => :destroy
  has_many :articles
  has_many :translations, :class_name => 'MagazineTranslation', :dependent => :destroy

  translate_columns :name, :description, :coord

  validates_presence_of :name, :description

  include SetIdentName
  
end
