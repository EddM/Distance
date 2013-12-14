class Enemy < EntityWithDepth

  def initialize(x, y, distance)
    super(x, y, distance)
    @color = Gosu::Color.argb(0xff00ff00)
  end

  def update

  end

  def draw
    unless @dead
      $window.draw_square @x, @y, 50, @color, -@distance
    end
  end

  def die!
    @dead = true
  end

end
