class GameWindow < Gosu::Window
  include Gosu

  attr_accessor :projectile

  # The horizon - the point at which projectiles disappear
  HorizonMax = 35000

  def initialize(w, h, full = false)
    super(w, h, full)
    $window = self

    @enemy = Enemy.new(200, 200, 16_500) # at 16.5km
    @obstacle = GameObject.new(210, 150, 16_000, 25, 200) # at 16.0km
    @environment = Environment.new(200, :east)

    @enemy.path = [
      { :type => :movement, :target => [300, 250] },
      { :type => :wait, :period => 3000 },
      { :type => :movement, :target => [200, 200] },
      { :type => :wait, :period => 1000 }
    ]
  end

  def draw
    @enemy.draw
    @obstacle.draw
    @projectile.draw if @projectile
  end

  def update
    fire! if button_down? MsLeft
    exit if button_down? KbEscape

    @enemy.update
    @projectile.update if @projectile
  end

  def fire!
    unless @projectile
      @firing = true
      @projectile = Projectile.new(mouse_x, mouse_y, @environment)
      @projectile.targets = [@enemy, @obstacle]
      puts "pew pew"
    end
  end

  def needs_cursor?
    true
  end

  def draw_square(x, y, size, color = Color.argb(0xff00ffff), z = 1)
    draw_quad x, y, color,
              x + size, y, color,
              x, y + size, color,
              x + size, y + size, color, z
  end

end
