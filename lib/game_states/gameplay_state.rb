class GameplayState < GameState
  
  def initialize
    @level = Level3.new
  end

  def next_level
    @level = (case @level
    when Level1 then Level2
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
