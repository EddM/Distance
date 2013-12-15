class Enemy < EntityWithDepth

  HeadshotThreshold = 0.285

  def initialize(x, y, distance)
    super(x, y, distance)
    @color = Gosu::Color.argb(0xff00ff00)
    @speed = 1
    @facing = :right
  end

  def update
    if @path
      @path_step = 0 if @path_step >= @path.size
      step = @path[@path_step]

      if step[:type] == :movement
        t_x, t_y = step[:target]
        look_left if t_x < @x
        look_right if t_x > @x
        move_towards t_x, t_y
        @path_step += 1 if @x.to_i == t_x.to_i && @y.to_i == t_y.to_i
      elsif step[:type] == :teleport
        t_x, t_y = step[:target]
        @x, @y = t_x, t_y
        @path_step += 1
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

  def die!(hit_x, hit_y)
    $window.sound_manager.play! :hurt
    headshot_box = BasicRect.new(x, y, width, height * HeadshotThreshold)
    headshot! if headshot_box.intersects_point?(hit_x, hit_y)
    @dead = true
  end

  def headshot!
    $window.sound_manager.play! :headshot
    puts "boom headshot"
  end

  def path=(steps)
    @path_step = 0
    @path = steps
  end

  def look_left
    @facing = :left
  end

  def look_right
    @facing = :right
  end

end
