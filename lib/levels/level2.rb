class Level2 < Level

  LightRotationSpeed = 0.1
  LightMaxAngle = 10
  LightMinAngle = -2
  
  def initialize
    super("Stage 2", "Clear the storage area of hostiles.")
    @environment = Environment.new(3, :west)
    @weapon = PSG1.new
    
    @light_angle = 0
    @light_dir = LightRotationSpeed

    TextTyper.type_locked = nil
    @texts = [
      TextTyper.new(50, 550, "LOC: STORAGE LOT"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WEP: #{@weapon.name}, #{@weapon.velocity} m/s"),
      TextTyper.new(50, 625, "ENV: WIND #{@environment.wind_direction.to_s[0..0].upcase}, #{@environment.wind_speed.to_i} km/h#{", #{@environment.weather.to_s.upcase}" if @environment.weather != :normal}")
    ]

    enemy = MaskedSoldier.new(50, 220, 800)
    enemy.path = [
      { :type => :movement, :target => [690, 400] },
      { :type => :wait, :period => 2500 },
      { :type => :movement, :target => [515, 510] },
      { :type => :wait, :period => 500 },
      { :type => :movement, :target => [515, 510] },
      { :type => :wait, :period => 500 },
      { :type => :movement, :target => [50, 270] },
      { :type => :wait, :period => 1000 }
    ]

    add_enemy enemy

    @boxes_left = BoxStack.new(35, 105)
    add_scenery @boxes_left

    @boxes_right = DoubleBoxStack.new(635, 150)
    add_scenery @boxes_right

    @overlay = Gosu::Image.new($window, "res/level2/darkness.png", false)

    @background = Gosu::Image.new($window, "res/level2/bg.png", false)

    @song = Gosu::Song.new($window, "res/music1.ogg")
    @song.play
  end

  def update
    super

    if playing?
      @texts.each { |t| t.update }
      @light_angle += @light_dir
      @light_dir = -LightRotationSpeed if @light_angle >= LightMaxAngle
      @light_dir = LightRotationSpeed if @light_angle <= LightMinAngle
    end
  end

  def draw
    super

    if playing?
      @texts.each { |t| t.draw }
      @background.draw 0, 0, -Z::Background
      @overlay.draw_rot 600, -50, -2, @light_angle, 0.5, 0
    end
  end

  def remove_projectile
    @projectile = nil
    if @enemies.any?
      game_over
    else
      $window.state_manager.current.next_level
    end
  end

end
