class Window < PenetrableObject

  SmashedMax = 50.0
  MaxAngle = 10.0
  Opacity = 25.0
  
  def initialize(x, y, width = 176, height = 88)
    @x, @y, @width, @height = x, y, width, height
    @distance = 1200
  end

  def update
    @smashed += 1 if @smashed
  end

  def draw
    color = Gosu::Color.argb(0xffa0f9ff)
    alpha = @smashed ? Opacity * (1 - (@smashed.to_f / SmashedMax)) : 25
    color.alpha = alpha
    piece_size = @height / 2.0

    @angle = MaxAngle * (@smashed.to_f / SmashedMax)

    x_offset = 0
    4.times do
      y_offset = 0 + (@smashed.to_i * 1)
      this_x_offset = x_offset - (50 * (@smashed.to_f / SmashedMax))
      $window.draw_triangle @x + this_x_offset, @y + y_offset, color,
                            @x + this_x_offset + piece_size, @y + y_offset, color,
                            @x + this_x_offset, @y + y_offset + piece_size, color

      y_offset = 0 + (@smashed.to_i * 2)
      this_x_offset = x_offset
      $window.draw_triangle @x + this_x_offset + piece_size, @y + y_offset, color,
                            @x + this_x_offset + piece_size, @y + y_offset + piece_size, color,
                            @x + this_x_offset, @y + y_offset + piece_size, color

      y_offset = 0 + (@smashed.to_i * 3)
      this_x_offset = x_offset - (50 * (@smashed.to_f / SmashedMax))
      $window.draw_triangle @x + this_x_offset, @y + piece_size + y_offset, color,
                            @x + this_x_offset + piece_size, @y + y_offset + piece_size, color,
                            @x + this_x_offset, @y + y_offset + (piece_size * 2), color

      y_offset = 0 + (@smashed.to_i * 4)
      this_x_offset = x_offset
      $window.draw_triangle @x + this_x_offset + piece_size, @y + y_offset + piece_size, color,
                            @x + this_x_offset + piece_size, @y + y_offset + (piece_size * 2), color,
                            @x + this_x_offset, @y + (piece_size * 2) + y_offset, color
      x_offset += piece_size
    end
  end

  def remove
    $window.sound_manager.play! :smash
    @smashed = 0
  end

end
