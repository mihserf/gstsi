class StoryPhoto < GstDb
  belongs_to :story
  has_attachment  :max_size => 2.megabytes, :content_type => :image, :resize_to => '420x300>',   :thumbnails => { :thumb => [50, 50], :view => 'x100' },
    :storage => :file_system, :path_prefix => 'public/photos/stories', :processor => 'ImageScience'
  validates_as_attachment
end
