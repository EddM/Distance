class Environment
  
  attr_reader :wind_speed, :wind_direction

  # wind speed in km/h
  def initialize(wind_speed = 0.0, wind_direction = :n)
    @wind_speed = wind_speed.to_f / 3600
    @wind_direction = wind_direction
  end

end
