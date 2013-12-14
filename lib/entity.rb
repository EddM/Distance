class Entity
  include Rect

  attr_reader :x, :y, :width, :height
  
  def initialize(x, y, width = 50, height = 50)
    @x, @y, @width, @height = x, y, width, height
  end

end
