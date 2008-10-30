

class Array
  def select_rotated(n=1)
    empty? ? nil : self[(Time.now.to_i/n) % size]
  end
end

