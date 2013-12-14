class Level1 < Level
  
  def initialize
    super
    @environment = Environment.new(5, :east, :snow)
    @texts = [
      TextTyper.new(50, 550, "LOC: 4N 8X 15Y"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WEP: HK PSG-1/7.62MM, 750 m/s"),
      TextTyper.new(50, 625, "ENV: WIND #{@environment.wind_direction.to_s[0..0].upcase}, #{@environment.wind_speed.to_i} km/h#{", #{@environment.weather.to_s.upcase}" if @environment.weather != :normal}")
    ]

    enemy = MaskedSoldier.new(25, 105, 1501)
    enemy.path = [
      { :type => :movement, :target => [90, 105] },
      { :type => :wait, :period => 1500 },
      { :type => :movement, :target => [25, 200] },
      { :type => :teleport, :target => [910, 200] },
      { :type => :movement, :target => [879, 105] },
      { :type => :movement, :target => [920, 105] },
      { :type => :wait, :period => 500 },
      { :type => :movement, :target => [879, 200] },
      { :type => :teleport, :target => [90, 200] },
      { :type => :movement, :target => [25, 105] },
      { :type => :wait, :period => 250 }
    ]

    add_enemy enemy

    @fence = Fence.new(0, 155)
    add_scenery @fence

    @background = Gosu::Image.new($window, "res/level1/bg.png", false)

    @song = Gosu::Song.new($window, "res/music1.ogg")
    @song.play
  end

  def update
    super

    @texts.each { |t| t.update }
  end

  def draw
    super

    @texts.each { |t| t.draw }
    @background.draw 0, 0, -Z::Background
  end

  def remove_projectile
    @projectile = nil
    if @enemies.any?
      game_over
    else
      $window.state_manager.current.next_level
    end
  end

  def game_over
    $window.sound_manager.play! :alarm
    @texts = [
      TextTyper.new(300, 300, "#{rand > 0.95 ? "FISSION MAILED" : "MISSION FAILED"}", $window.big_font),
      TextTyper.new(300, 350, "You missed the shot.", $window.big_font),
    ]
  end

end
