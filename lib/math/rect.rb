module Rect

  attr_reader :x, :y, :width, :height

  def right
    x + width
  end

  def bottom
    x + height
  end
  
  def intersects_point?(p_x, p_y)
    p_x >= x && p_x <= right && p_y >= y && p_y <= bottom
  end

end
