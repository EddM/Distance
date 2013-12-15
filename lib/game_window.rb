class GameWindow < Gosu::Window
  include Gosu

  attr_reader :state_manager, :sound_manager, :player, :font, :big_font

  # The horizon - the point at which projectiles disappear
  HorizonMax = 5_000

  def initialize(w, h, full = false)
    super(w, h, full)
    $window = self

    setup_resources

    @player = Player.new

    @state_manager = GameStateManager.new
    @state_manager << MenuState.new
  end

  def draw
    @state_manager.current.draw
  end

  def update
    $input_disabled -= 1 if input_disabled?
    self.caption = "Distance (#{fps} FPS)"
    exit if button_down? KbEscape

    @state_manager.current.update
  end

  def input_disabled?
    $input_disabled && $input_disabled > 0
  end

  def needs_cursor?
    # true
    false
  end

  def draw_triangle_rot(angle, x1, y1, c1, x2, y2, c2, x3, y3, c3, z = 0, mode = :default)
    draw_triangle(x1, y1, c1, x2, y2, c2, x3, y3, c3, z, mode)
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

  def setup_resources
    @sound_manager = SoundManager.new
    @font = Font.new(self, "Silom", 18)
    @big_font = Font.new(self, "Silom", 32)
  end

end
