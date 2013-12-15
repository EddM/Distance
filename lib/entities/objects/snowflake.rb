class Snowflake

  DownwardVelocity = 0.3

  attr_reader :x, :y, :size

  def initialize(x, y)
    @x, @y = x, y
    @size = 2 + rand(4)
    @opacity = 155 + (100 * rand)
    @downward_velocity = 0.5 + rand(DownwardVelocity)
    @horizontal_variation = rand(100)
    @original_x = x
    @float_dir = 1

    @r = rand(3)
  end

  def update
    @y += @downward_velocity
    if @r == 0
      @third_vertex = [@x + @size, @y + @size]
    elsif @r == 1
      @third_vertex = [@x + @size, @y + (@size / 2.0)]
    elsif @r == 2
      @third_vertex = [@x + @size, @y - @size]
    end

    @x += @float_dir
    @float_dir = -1 if @x >= (@original_x + @horizontal_variation)
    @float_dir = 1 if @x <= (@original_x - @horizontal_variation)
  end
  
  def draw
    color = Gosu::Color.argb(0xccffffff)
    color.alpha = @opacity
    if @third_vertex
      $window.draw_triangle @x, @y, color,
                            @x + @size, @y, color,
                            @third_vertex[0], @third_vertex[1], color
    end
  end

end
