class Level1 < Level
  
  def initialize
    super
    @environment = Environment.new(5, :east)

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
  end

  def draw
    super

    @background.draw 0, 0, -Z::Background
  end

end
