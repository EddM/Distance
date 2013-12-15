class Level

  attr_accessor :projectile
  attr_reader :environment, :enemies, :objects

  def initialize(name, description)
    @enemies, @objects, @scenery = [], [], []
    @name, @description = name, description
    @scope = Gosu::Image.new($window, "res/scope1.png", false)

    @stage_text = TextTyper.new(300, 250, @name, $window.big_font)
    @desc_text = TextTyper.new(300, 300, @description)
    @proceed_text = TextTyper.new(300, 400, "Click to begin")

    Level.current = self
  end

  def playing?
    !@stage_text && !@desc_text
  end

  def update
    @projectile.update if @projectile

    unless playing?
      @stage_text.update
      @desc_text.update
      @proceed_text.update

      unless $window.input_disabled?
        if $window.button_down? Gosu::MsLeft
          @stage_text = nil
          @desc_text = nil
          TextTyper.type_locked = nil
          $input_disabled = 100
        end
      end
    else
      if @game_over
        unless $window.input_disabled?
          restart if $window.button_down? Gosu::MsLeft
        end
      else
        unless $window.input_disabled?
          check_distance if $window.button_down? Gosu::KbSpace
          fire! if $window.button_down? Gosu::MsLeft
        end

        @environment.update
        @enemies.each { |e| e.update }
        @objects.each { |e| e.update }

        if @distance_text
          @distance_text.opacity -= 0.01
          @distance_text.update
          @distance_text = nil if @distance_text.opacity <= 0
        end
      end
    end
  end

  def draw
    @projectile.draw if @projectile

    unless playing?
      $window.draw_quad 0, 0, Gosu::Color::BLACK,
                        $window.width, 0, Gosu::Color::BLACK,
                        0, $window.height, Gosu::Color::BLACK,
                        $window.width, $window.height, Gosu::Color::BLACK, Z::UI
      @stage_text.draw 
      @desc_text.draw
      @proceed_text.draw
    else
      @enemies.each { |e| e.draw }
      @objects.each { |e| e.draw }
      @scenery.each { |e| e.draw } 
      @environment.draw

      if @distance_text
        @distance_text.draw
      end
    end

    draw_scope
  end

  def fire!
    unless @projectile
      @projectile = Projectile.new($window.mouse_x, $window.mouse_y, @environment, @weapon)
      @projectile.targets = @enemies + @objects + @scenery
    end
  end

  def check_distance
    unless @distance_text
      (@enemies + @objects).sort_by { |t| t.distance }.each do |target|
        if target.intersects_point?($window.mouse_x, $window.mouse_y)
          @distance_text = TextTyper.new($window.mouse_x + 25, $window.mouse_y + 25, "RNG: #{target.distance}m")
          return
        end
      end
    end
  end

  def add_enemy(object)
    @enemies << object
  end

  def add_object(object)
    @objects << object
  end

  def add_scenery(object)
    @scenery << object
  end

  def game_over
    $window.sound_manager.play! :alarm
    TextTyper.type_locked = nil
    @texts = [
      TextTyper.new(300, 300, "#{rand > 0.95 ? "FISSION MAILED" : "MISSION FAILED"}", $window.big_font),
      TextTyper.new(300, 350, "You missed the shot.", $window.big_font),
      TextTyper.new(300, 425, "Click to restart")
    ]
    @game_over = true
  end

  def restart
    $window.state_manager.current.restart
  end

  def complete
    $window.state_manager.current.next_level
  end

  def self.current=(level)
    @level = level
  end

  def self.current
    @level
  end

  private

  def draw_scope
    scope_x = $window.mouse_x
    scope_y = $window.mouse_y
    scope_x = 0 if scope_x < 0
    scope_x = $window.width if scope_x > $window.width
    scope_y = 0 if scope_y < 0
    scope_y = $window.height if scope_y > $window.height
    @scope.draw scope_x - (@scope.width / 2), scope_y - (@scope.height / 2), 0
  end

end
