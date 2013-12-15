class GameplayState < GameState
  
  def initialize
    @level = Level1.new
  end

  def restart
    @level = @level.class.new
  end

  def next_level
    @level = (case @level
    when Level1 then Level2
    when Level2 then Level3
    end).new
  end

  def draw
    @level.draw
    super
  end

  def update
    @level.update
  end

end
