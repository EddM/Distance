class Level

  attr_accessor :projectile
  attr_reader :environment, :enemies, :objects

  def initialize
    @enemies, @objects, @scenery = [], [], []
    @scope = Gosu::Image.new($window, "res/scope1.png", false)
    Level.current = self
  end

  def update
    @projectile.update if @projectile

    @enemies.each { |e| e.update }
    @objects.each { |e| e.update }

    if @distance_text
      @distance_text.opacity -= 0.02
      @distance_text.update
      @distance_text = nil if @distance_text.opacity <= 0
    end
  end

  def draw
    @projectile.draw if @projectile

    @enemies.each { |e| e.draw }
    @objects.each { |e| e.draw }
    @scenery.each { |e| e.draw } 

    if @distance_text
      @distance_text.draw
    end

    draw_scope
  end

  def fire!
    unless @projectile
      @projectile = Projectile.new($window.mouse_x, $window.mouse_y, @environment)
      @projectile.targets = @enemies + @objects + @scenery
    end
  end

  def check_distance
    unless @distance_text
      (@enemies + @objects).sort_by { |t| t.distance }.each do |target|
        if target.intersects_point?($window.mouse_x, $window.mouse_y)
          @distance_text = TextTyper.new($window.mouse_x + 25, $window.mouse_y + 25, "RNG: #{target.distance}M")
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

  # Level end logic?
  def remove_projectile
    raise "Not yet implemented"
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
