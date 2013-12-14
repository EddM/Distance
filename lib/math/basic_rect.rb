class BasicRect
  include Rect

  def initialize(x, y, width = 50, height = 50)
    @x, @y, @width, @height = x, y, width, height
  end  
end
