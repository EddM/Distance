class GameplayState < GameState
  
  def initialize
    @level = Level1.new
  end

  def restart
    @level = @level.class.new
  end

  def next_level
    if @level.is_a?(Level5)
      $window.state_manager.pop
      $window.state_manager.push CompletionState.new
    else
      @level = (case @level
      when Level1 then Level2
      when Level2 then Level3
      when Level3 then Level4
      when Level4 then Level5
      end).new
    end
  end

  def draw
    @level.draw
    super
  end

  def update
    @level.update
  end

end
