class Projectile < Entity

  Size = 5.0

  def initialize(x, y, environment, velocity = 800)
    super(x - (Size / 2.0), y - (Size / 2.0))
    @environment = environment
    @velocity = velocity
    @distance = 0.0
    @previous_distance = 0.0
    @size = Size
  end

  def update
    # Move forward in space
    @previous_distance = @distance
    @distance += @velocity

    # Bullet drop
    @y += Math::Constants::Gravity / $window.update_interval

    if @environment.wind_direction == :east
      @x += @environment.wind_speed / $window.update_interval
    elsif @environment.wind_direction == :west
      @x -= @environment.wind_speed / $window.update_interval
    end

    # Check targets
    @targets.each do |t|
      if (t.distance == @distance || (t.distance > @previous_distance && t.distance < @distance)) && t.intersects_point?(@x, @y)

        if t.is_a?(GameObject)
          if t.penetrable?
            @targets.delete(t) if t.remove
            next
          else
            remove
          end
        elsif t.is_a?(Enemy)
          @targets.delete(t)
          t.die!
          remove
        end
      end
    end

    # Go away if beyond boundary
    remove if @distance >= GameWindow::HorizonMax
  end

  def draw
    @size = Size - (Size * (@distance / GameWindow::HorizonMax))
    $window.draw_square(@x, @y, @size, Gosu::Color::RED, -@distance)
  end

  def targets=(array)
    @targets = array.sort_by { |t| t.distance }
  end

  private

  def remove
    $window.projectile = nil
  end

end
