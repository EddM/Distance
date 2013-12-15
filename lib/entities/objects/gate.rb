class Gate < PenetrableObject

  def initialize(x, y, width = 1024, height = 227)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/level5/gate.png", false)
    @distance = 1900
  end

  def draw
    @image.draw x, y, -@distance
  end

end
