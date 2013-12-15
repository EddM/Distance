class Hut < PenetrableObject

  def initialize(x, y, width = 500, height = 244)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level4/hut.png", false)
    @distance = 1200
  end

  def draw
    @image.draw x, y, -@distance
  end

end
