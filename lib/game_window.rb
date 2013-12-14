class GameWindow < Gosu::Window
  include Gosu

  attr_accessor :projectile

  # The horizon - the point at which projectiles disappear
  HorizonZ = 35_000

  def initialize(w, h, full = false)
    super(w, h, full)
    $window = self

    @enemy = Enemy.new(200, 200, 100)
  end

  def draw
    @enemy.draw
    @projectile.draw if @projectile
  end

  def update
    fire! if button_down? MsLeft

    @projectile.update if @projectile
  end

  def fire!
    unless @projectile
      @firing = true
      @projectile = Projectile.new(mouse_x, mouse_y)
      puts "pew pew"
    end
  end

  def needs_cursor?
    true
  end

  def draw_square(x, y, size, color = Color.argb(0xff00ffff))
    draw_quad x, y, color,
              x + size, y, color,
              x, y + size, color,
              x + size, y + size, color
  end

end
