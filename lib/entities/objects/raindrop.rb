class Raindrop

  DownwardVelocity = 8

  attr_reader :x, :y, :size

  def initialize(x, y)
    @x, @y = x, y
    @size = 10 + rand(10)
    @opacity = 200 * rand
    @downward_velocity = 2 + rand(DownwardVelocity)

    @r = rand(3)
  end

  def update
    @y += @downward_velocity
  end
  
  def draw
    color = Gosu::Color.argb(0xff4377a9)
    color.alpha = @opacity

    $window.draw_line @x, @y, color,
                      @x, @y + @size, color, -101

  end

end
