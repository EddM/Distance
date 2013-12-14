class Projectile < Entity

  Size = 5.0
  Gravity = 9.81 # m/s

  def initialize(x, y, environment, velocity = 250)    
    super(x - (Size / 2.0), y - (Size / 2.0))
    @environment = environment
    @velocity = velocity
    @distance = 0.0
    @size = Size
  end

  def update
    # Move forward in space
    @distance += @velocity

    # Bullet drop
    @y += Gravity / $window.update_interval

    # Wind effects -- TO BE PERFECTED
    if @environment.wind_direction == :east
      @x += @environment.wind_speed / $window.update_interval
    elsif @environment.wind_direction == :west
      @x -= @environment.wind_speed / $window.update_interval
    end

    # Go away if beyond boundary
    remove if @distance >= GameWindow::HorizonMax
  end

  def draw
    @size = Size - (Size * (@distance / GameWindow::HorizonMax))
    $window.draw_square(@x, @y, @size, Gosu::Color::RED)
  end

  private

  def remove
    $window.projectile = nil
  end

end
