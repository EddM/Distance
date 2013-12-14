class Fence < GameObject

  def initialize(x, y, width = 1024, height = 412)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level1/fence.png", false)
    @distance = 1450
  end

  def draw
    @image.draw x, y, -@distance
  end

end
