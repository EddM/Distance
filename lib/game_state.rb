class GameState

  def exclusive?
    true
  end

  def update
    raise "Not yet implemented"
  end

  def draw
    $window.state_manager.previous.draw unless exclusive?
  end

end

class NonExclusiveGameState < GameState
  
  def exclusive?
    false
  end
  
end
