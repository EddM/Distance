class HowtoState < GameState
  include Interaction
  
  def initialize
    @text = Gosu::Image.new($window, "res/howto-text.png", false)
    @back_button = Button.new(75, 650, :back, 108, 32, Proc.new {
      $window.state_manager.pop
    })
  end

  def update
    @back_button.update
  end

  def draw
    @text.draw 0, 0, Z::UI
    @back_button.draw
    draw_scope
  end

end
