class GameWindow < Gosu::Window
  include Gosu

  attr_reader :sound_manager, :font, :big_font

  # The horizon - the point at which projectiles disappear
  HorizonMax = 5_000

  def initialize(w, h, full = false)
    super(w, h, full)
    $window = self

    @sound_manager = SoundManager.new
    @font = Font.new(self, "Silom", 18)
    @big_font = Font.new(self, "Silom", 32)

    @level = Level1.new
  end

  def draw
    @level.draw
  end

  def update
    self.caption = "#{fps} FPS"
    exit if button_down? KbEscape

    @level.update
    @level.fire! if button_down? MsLeft
  end

  def needs_cursor?
    # true
    false
  end

  def draw_square(x, y, size, color = Color.argb(0xff00ffff), z = 1)
    draw_quad x, y, color,
              x + size, y, color,
              x, y + size, color,
              x + size, y + size, color, z
  end

  private

  def draw_background
    draw_quad 0, 0, Color.argb(0xffcccccc),
              width, 0, Color.argb(0xffcccccc),
              0, height, Color.argb(0xffcccccc),
              width, height, Color.argb(0xffcccccc), -HorizonMax
  end

end
