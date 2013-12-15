class BoxStack < GameObject

  def initialize(x, y, width = 284, height = 440)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level2/boxes-left.png", false)
    @distance = 500
  end

  def draw
    @image.draw x, y, -@distance
  end

end

class DoubleBoxStack < GameObject

  def initialize(x, y, width = 388, height = 514)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level2/boxes-right.png", false)
    @distance = 490
  end

  def draw
    @image.draw x, y, -@distance
  end

end
