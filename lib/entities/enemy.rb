class Enemy
  
  def initialize(x, y, z)
    @x, @y, @z = x, y, z
  end

  def update

  end

  def draw
    $window.draw_square @x, @y, 50
  end

end
