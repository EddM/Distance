class TextTyper

  def initialize(x, y, text, font = $window.font, padding = 8)
    @x, @y, @text, @padding = x, y, text, padding
    @font = font
    @text_width = @font.text_width text
    @index = -1
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
    @font.draw @text[0..@index], @x + @padding, @y + @padding, Z::UI
  end

  def draw_background
    $window.draw_quad @x, @y, 0xcc000000,
                      @x + @text_width + (@padding * 2), @y, 0xcc000000,
                      @x, @y + @font.height + (@padding * 2), 0xcc000000,
                      @x + @text_width + (@padding * 2), @y + @font.height + (@padding * 2), 0xcc000000, Z::UI
  end

  def self.type_locked=(typer)
    @type_locked = typer
  end

  def self.type_locked
    @type_locked
  end

end
