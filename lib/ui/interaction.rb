module Interaction
  
  def draw_scope
    @scope ||= Gosu::Image.new($window, "res/crosshair.png", false)
    scope_x = $window.mouse_x
    scope_y = $window.mouse_y
    scope_x = 0 if scope_x < 0
    scope_x = $window.width if scope_x > $window.width
    scope_y = 0 if scope_y < 0
    scope_y = $window.height if scope_y > $window.height
    @scope.draw scope_x - (@scope.width / 2), scope_y - (@scope.height / 2), Z::UI
  end
  
end
