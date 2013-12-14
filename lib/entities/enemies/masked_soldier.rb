class MaskedSoldier < Enemy

  def initialize(x, y, distance)
    super(x, y, distance)
    @images = Gosu::Image.load_tiles($window, "res/enemies/masked.png", 32, 56, false)
    @speed = 1
  end

  def draw
    unless @dead
      @images[@facing == :right ? 0 : 1].draw(@x, @y, -@distance)
    end
  end

end
