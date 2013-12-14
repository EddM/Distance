module Rect

  def right
    x + width
  end

  def bottom
    x + height
  end
  
  def intersects_point?(p_x, p_y)
    x <= p_x && right >= p_x && y <= p_y && bottom >= p_y
  end

end
