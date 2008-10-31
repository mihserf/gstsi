

class Array
  def select_rotated(n=1)
    empty? ? nil : self[(Time.now.to_i/n) % size]
  end
end

module ActionView
  module AssertTagHelper
    def ext_image_tag(source, options = {})
      image_tag("http://queenofbeauty.com.ua"+source,options)
    end
  end
end
