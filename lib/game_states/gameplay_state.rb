class GameplayState < GameState
  
  def initialize
    @level = Level1.new
  end

  def next_level
    @level = (case @level
    when Level1 then Level1
    end).new
  end

  def draw
    @level.draw
    super
  end

  def update
    @level.check_distance if $window.button_down? Gosu::KbSpace
    @level.fire! if $window.button_down? Gosu::MsLeft
    @level.update
  end

end
