require 'math/rect'

class Box
  include Rect
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width = 50, height = width)
    @x, @y, @width, @height = x, y, width, height
  end
end

describe Rect do
  
  it "intersects point" do
    rect = Box.new(400, 450, 15, 50) # Extends to [125, 125]

    rect.intersects_point?(402, 483).should == true
  end

end
