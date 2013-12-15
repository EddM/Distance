class Level3 < Level

  def initialize
    super("Stage 3", "Take out the guards around the barracks.")
    @environment = Environment.new(13, :east)
    @weapon = PSG1Suppressed.new

    TextTyper.type_locked = nil
    @texts = [
      TextTyper.new(50, 550, "LOC: BARRACKS"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WEP: #{@weapon.name}, #{@weapon.velocity} m/s"),
      TextTyper.new(50, 625, "ENV: WIND #{@environment.wind_direction.to_s[0..0].upcase}, 28 km/h#{", #{@environment.weather.to_s.upcase}" if @environment.weather != :normal}")
    ]

    enemy = MaskedSoldier.new(0, 420, 1250)
    enemy.path = [
      { :type => :wait, :period => 400 },
      { :type => :movement, :target => [150, 420] },
      { :type => :wait, :period => 400 },
      { :type => :movement, :target => [0, 420] }
    ]
    add_enemy enemy

    enemy = MaskedSoldier.new(665, 460, 1250)
    add_enemy enemy

    @background = Gosu::Image.new($window, "res/level4/bg.png", false)

    add_scenery Hut.new(-10, 330)
    add_object Window.new(46, 378)
    add_object Window.new(270, 378)

    @song = Gosu::Song.new($window, "res/music4.ogg")
    @song.play(true)
  end

  def update
    super

    if playing?
      @texts.each { |t| t.update }
    end
  end

  def draw
    super

    if playing?
      @texts.each { |t| t.draw }
      @background.draw 0, 0, -Z::Background
    end
  end

  def remove_projectile
    @projectile = nil
  end

end
