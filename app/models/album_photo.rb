class AlbumPhoto < GstDb
  belongs_to :album
  has_many :translations, :class_name => 'AlbumPhotoTranslation', :dependent => :destroy
  translate_columns  :description

  has_attachment  :max_size => 2.megabytes, :content_type => :image, :resize_to => '520x400>',   :thumbnails => { :thumb => '100x100', :view => 'x180' },
    :storage => :file_system, :path_prefix => 'public/photos/albums', :processor => 'ImageScience'
  validates_as_attachment

end
