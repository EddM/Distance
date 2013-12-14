class GameObject < EntityWithDepth

  def penetrable?
    true
  end

  def draw
    color = Gosu::Color.argb(0xffffffff)
    $window.draw_quad x, y, color,
                      x + width, y, color,
                      x, y + height, color,
                      x + width, y + height, color, -@distance
  end

  def remove
    # Doesn't necessarily need to do anything
  end

end
