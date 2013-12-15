class Environment
  
  Flakes = 2000

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
  end

  def draw
    if @weather == :snow
      @flakes.each do |flake|
        flake.draw
      end
    end
  end

end
