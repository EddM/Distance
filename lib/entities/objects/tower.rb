class Tower < PenetrableObject

  def initialize(x, y, width = 144, height = 428)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level3/tower.png", false)
    @distance = 2335
  end

  def draw
    @image.draw x, y, -@distance
  end

end
