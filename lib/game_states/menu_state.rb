class MenuState < GameState
  include Interaction
  
  BlinkSpeed = 1500

  def initialize
    @song = Gosu::Song.new($window, "res/intro.ogg")
    @song.play(true)

    @logo = Gosu::Image.new($window, "res/logo.png", false)
    @images = Gosu::Image.load_tiles($window, "res/logo.png", 416, 56, false)
    @image_index = 0
    @background = Gosu::Image.new($window, "res/menu.png", false)

    @start_button = Button.new(100, 350, :start, 312, 32, Proc.new {
      $window.state_manager.push IntroState.new
    })
    @howto_button = Button.new(100, 400, :howto, 272, 32, Proc.new {
      $window.state_manager.push HowtoState.new
    })
    @about_button = Button.new(100, 450, :credits, 164, 32, Proc.new {
      $window.state_manager.push AboutState.new
    })
  end

  def update
    @start_button.update
    @howto_button.update
    @about_button.update
  end

  def draw
    @images[Gosu.milliseconds % BlinkSpeed < (BlinkSpeed / 2) ? 0 : 1].draw 100, 100, 1
    @background.draw 0, 0, -Z::Background

    @start_button.draw
    @howto_button.draw
    @about_button.draw

    draw_scope
  end

end
