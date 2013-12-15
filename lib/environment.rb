class Environment
  
  Flakes = 2000
  Raindrops = 1000

  attr_reader :wind_speed, :wind_direction, :weather

  # wind speed in km/h
  def initialize(wind_speed = 0.0, wind_direction = :n, weather = :normal)
    @wind_speed = (wind_speed.to_f * 1000) / 3600
    @wind_direction = wind_direction
    @weather = weather

    if @weather == :snow
      @flakes = []
      Flakes.times do
        @flakes << Snowflake.new(rand($window.width), rand($window.height))
      end
    end

    if @weather == :rain
      @darkness_opacity = 1.0
      @next_flash = 0

      @raindrops = []
      Raindrops.times do
        @raindrops << Raindrop.new(rand($window.width), rand($window.height))
      end
    end
  end

  def schedule_flash
    @next_flash = Gosu::milliseconds + 3000 + (rand(10) * 20)
  end

  def update
    if @weather == :snow
      @flakes.each do |flake|
        flake.update
        if flake.y >= $window.height
          @flakes << Snowflake.new(rand($window.width), -10)
          @flakes.delete flake
        end
      end
    end

    if @weather == :rain
      @raindrops.each do |drop|
        drop.update
        if drop.y >= $window.height
          @raindrops << Raindrop.new(rand($window.width), -10)
          @raindrops.delete drop
        end
      end

      if !@flashing && Gosu::milliseconds >= @next_flash
        @flashing = 100
        $window.sound_manager.play! :"thunder#{rand(4)}"
      end

      if @flashing
        if @flashing > 90
          @darkness_opacity = 0.1
        elsif @flashing < 60
          @darkness_opacity = 1 - (@flashing.to_f / 60.0)
        else
          @darkness_opacity = 1
        end

        @flashing -= 2
        if @flashing <= 0
          schedule_flash
          @flashing = nil
        end
      end
    end
  end

  def draw
    if @weather == :snow
      @flakes.each { |flake| flake.draw }
    end

    if @weather == :rain
      @raindrops.each { |drop| drop.draw }

      color = Gosu::Color.argb(0xff000000)
      color.alpha = 175 * @darkness_opacity

      $window.draw_quad 0, 0, color,
                        $window.width, 0, color,
                        0, $window.height, color,
                        $window.width, $window.height, color, -100
    end
  end

end
