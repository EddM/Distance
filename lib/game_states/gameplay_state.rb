class GameplayState < GameState
  
  def initialize
    @level = Level4.new
  end

  def restart
    @level = @level.class.new
  end

  def next_level
    if @level.is_a?(Level4)
      $window.state_manager.pop
      $window.state_manager.push CompletionState.new
    else
      @level = (case @level
      when Level1 then Level2
      when Level2 then Level3
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
