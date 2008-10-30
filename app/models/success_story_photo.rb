class SuccessStoryPhoto < GstDb
  belongs_to :success_story
  has_attachment  :max_size => 2.megabytes, :content_type => :image, :resize_to => '420x300>',   :thumbnails => { :thumb => [50, 50], :view => 'x143' },
    :storage => :file_system, :path_prefix => 'public/photos/success_stories', :processor => 'ImageScience'
  validates_as_attachment
end
