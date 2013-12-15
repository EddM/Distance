class Button
  include Rect
  
  def initialize(x, y, image, width, height = 32, callback = nil)
    @x, @y, @width, @height = x, y, width, height
    @image = Gosu::Image.new($window, "res/#{image.to_s}.png", false, 0, 0, width, height)
    @hover = Gosu::Image.new($window, "res/#{image.to_s}_over.png", false, 0, 0, width, height)
    @callback = callback
  end
  
  def width
    @image.width
  end
  
  def height
    @image.height
  end
  
  def hovering?
    intersects_point?($window.mouse_x, $window.mouse_y)
  end
  
  def update
    if hovering?
      $window.sound_manager.play! :bleep unless @already_hovering
      @already_hovering = true
    else
      @already_hovering = false
    end

    if ($window.button_down?(Gosu::MsLeft) || $window.button_down?(Gosu::MsRight)) && hovering? && @callback
      unless $window.input_disabled?
        $window.sound_manager.play! :select
        @callback.call
        $input_disabled = 25
      end
    end
  end
  
  def draw
    if @hover && hovering?
      @hover.draw @x, @y, Z::UI
    else
      @image.draw @x, @y, Z::UI
    end
  end
  
end
