class Enemy < EntityWithDepth

  def initialize(x, y, distance)
    super(x, y, distance)
    @color = Gosu::Color.argb(0xff00ff00)
    @speed = 1
  end

  def update
    if @path
      @path_step = 0 if @path_step >= @path.size
      step = @path[@path_step]

      if step[:type] == :movement
        t_x, t_y = step[:target]
        move_towards t_x, t_y
        @path_step += 1 if @x.to_i == t_x.to_i && @y.to_i == t_y.to_i
      elsif step[:type] == :wait
        time_to_wait = step[:period]
        @time_waited ||= 0
        @time_waited += $window.update_interval
        if time_to_wait <= @time_waited
          @path_step += 1
          @time_waited = nil
        end
      end
    end
  end

  def move_towards(t_x, t_y)
    if @x < t_x
      @x += @speed
    elsif @x > t_x
      @x -= @speed
    end

    if @y < t_y
      @y += @speed
    elsif @y > t_y
      @y -= @speed
    end
  end

  def draw
    unless @dead
      $window.draw_square @x, @y, width, @color, -@distance
    end
  end

  def die!
    @dead = true
  end

  def path=(steps)
    @path_step = 0
    @path = steps
  end

end
