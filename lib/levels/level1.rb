class Level1 < Level
  
  def initialize
    super
    @environment = Environment.new(5, :east)
    @texts = [
      TextTyper.new(50, 550, "LOC: 4N 8X 15Y"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WIND: #{@environment.wind_direction.to_s[0..0].upcase}, #{@environment.wind_speed.to_i} km/h")
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

    Level.current = self
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
      $window.sound_manager.play! :alarm
      @texts = [
        TextTyper.new(300, 300, "#{rand > 0.95 ? "FISSION MAILED" : "MISSION FAILED"}", $window.big_font),
        TextTyper.new(300, 350, "You missed the shot.", $window.big_font),
      ]
    end
  end

end
