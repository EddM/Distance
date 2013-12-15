class Level4 < Level
  
  def initialize
    super("Stage 4", "Take out the radar tower guards, but beware of the strong weather conditions.")
    @environment = Environment.new(28, :west, :snow)
    @weapon = PSG1Suppressed.new

    TextTyper.type_locked = nil
    @texts = [
      TextTyper.new(50, 550, "LOC: RADAR TOWER"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WEP: #{@weapon.name}, #{@weapon.velocity} m/s"),
      TextTyper.new(50, 625, "ENV: WIND #{@environment.wind_direction.to_s[0..0].upcase}, 28 km/h#{", #{@environment.weather.to_s.upcase}" if @environment.weather != :normal}")
    ]

    enemy = SnowSoldier.new(880, 240, 2340)
    enemy.path = [
      { :type => :wait, :period => 400 },
      { :type => :movement, :target => [875, 240] },
      { :type => :wait, :period => 500 },
      { :type => :movement, :target => [870, 240] },
      { :type => :wait, :period => 1000 },
      { :type => :movement, :target => [880, 240] }
    ]
    add_enemy enemy

    enemy = SnowSoldier.new(235, 460, 2210)
    enemy.path = [
      { :type => :wait, :period => 400 },
      { :type => :movement, :target => [470, 450] },
      { :type => :wait, :period => 3500 },
      { :type => :movement, :target => [235, 460] }
    ]
    add_enemy enemy

    @tower = Tower.new(760, 120)
    add_scenery @tower

    @background = Gosu::Image.new($window, "res/level3/bg.png", false)

    @song = Gosu::Song.new($window, "res/music3.ogg")
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
