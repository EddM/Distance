class TextTyper

  attr_accessor :opacity

  def initialize(x, y, text, font = $window.font, padding = 8)
    @x, @y, @text, @padding = x, y, text, padding
    @font = font
    @text_width = @font.text_width text
    @index = -1
    @opacity = 1.0
  end

  def update
    self.class.type_locked = self unless self.class.type_locked

    if self.class.type_locked == self
      if @index == @text.size
        self.class.type_locked = nil
      else
        @index += 1
      end
    end
  end

  def draw
    draw_background
    draw_font unless @index < 0
  end

  private

  def draw_font
    color = Gosu::Color.argb(0xffffffff)
    color.alpha = 255 * @opacity
    @font.draw @text[0..@index], @x + @padding, @y + @padding, Z::UI, 1, 1, color
  end

  def draw_background
    color = Gosu::Color.argb(0xcc000000)
    color.alpha = 205 * @opacity

    $window.draw_quad @x, @y, color,
                      @x + @text_width + (@padding * 2), @y, color,
                      @x, @y + @font.height + (@padding * 2), color,
                      @x + @text_width + (@padding * 2), @y + @font.height + (@padding * 2), color, Z::UI
  end

  def self.type_locked=(typer)
    @type_locked = typer
  end

  def self.type_locked
    @type_locked
  end

end
