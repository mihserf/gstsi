class MagazineLogo < GstDb
  belongs_to :magazine
  has_attachment  :max_size => 2.megabytes, :content_type => :image, :resize_to => '220x200>',   :thumbnails => { :thumb => '100x100', :view => 'x180' },
    :storage => :file_system, :path_prefix => 'public/photos/magazine/logos', :processor => 'ImageScience'
  validates_as_attachment
end
