class Environment
  
  attr_reader :wind_speed, :wind_direction, :weather

  # wind speed in km/h
  def initialize(wind_speed = 0.0, wind_direction = :n, weather = :normal)
    @wind_speed = (wind_speed.to_f * 1000) / 3600
    @wind_direction = wind_direction
    @weather = weather
  end

end
