class MemberPhoto < GstDb
  belongs_to :member

  has_attachment  :max_size => 2.megabytes, :content_type => :image, :resize_to => '420x300>',   :thumbnails => { :thumb => [50, 50], :view => 'x120' },
    :storage => :file_system, :path_prefix => 'public/photos/members', :processor => 'ImageScience'
  validates_as_attachment

  

end
