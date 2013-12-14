class Projectile < Entity

  Size = 5.0
  Gravity = 9.81 # m/s

  def initialize(x, y, velocity = 850)
    super(x, y)
    @velocity = velocity
    @distance = 0.0
    @size = Size
  end

  def update
    @distance += @velocity
    @y += Gravity / $window.update_interval
    @size = Size - (Size * (@distance / GameWindow::HorizonZ))

    remove if @distance >= GameWindow::HorizonZ
  end

  def draw
    $window.draw_square(@x, @y, @size, Gosu::Color::RED)
  end

  private

  def remove
    $window.projectile = nil
  end

end
