class SnowSoldier < Enemy

  def initialize(x, y, distance)
    super(x, y, distance)
    @images = Gosu::Image.load_tiles($window, "res/enemies/snow.png", 16, 28, false)
    @speed = 1
  end

  def draw
    unless @dead
      @images[@facing == :right ? 0 : 1].draw(@x, @y, -@distance)
    end
  end

end
