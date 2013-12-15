class Level2 < Level
  
  def initialize
    super("Stage 2, Perimeter Gate", "Clear the gate security to allow Cobra Team to enter")
    @environment = Environment.new(7, :east, :rain)
    @weapon = PSG1.new

    TextTyper.type_locked = nil
    @texts = [
      TextTyper.new(50, 550, "LOC: PERIMETER GATE"),
      TextTyper.new(50, 575, "TGT: CLASSIFIED"),
      TextTyper.new(50, 600, "WEP: #{@weapon.name}, #{@weapon.velocity} m/s"),
      TextTyper.new(50, 625, "ENV: WIND #{@environment.wind_direction.to_s[0..0].upcase}, 7 km/h#{", #{@environment.weather.to_s.upcase}" if @environment.weather != :normal}")
    ]

    add_enemy MaskedSoldier.new(825, 300, 1950)

    enemy = MaskedSoldier.new(300, 390, 1880)
    enemy.path = [
      { :type => :wait, :period => 1500 },
      { :type => :movement, :target => [425, 390] },
      { :type => :wait, :period => 1500 },
      { :type => :movement, :target => [300, 390] }
    ]

    add_enemy enemy

    @gate = Gate.new(0, 155)
    add_scenery @gate

    @background = Gosu::Image.new($window, "res/level5/bg.png", false)

    @song = Gosu::Song.new($window, "res/music5.ogg")
    @song.play(true)
  end

  def update
    super

    if playing?
      @environment.update
      @texts.each { |t| t.update }
    end
  end

  def draw
    super

    if playing?
      @environment.draw
      @texts.each { |t| t.draw }
      @background.draw 0, 0, -Z::Background
    end
  end

  def remove_projectile
    @projectile = nil
  end

end
