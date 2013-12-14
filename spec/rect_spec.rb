require 'math/rect'

class Box
  include Rect
  attr_reader :x, :y, :width, :height

  def initialize(x, y, size = 50)
    @x, @y, @width, @height = x, y, size, size
  end
end

describe Rect do
  
  it "intersects point" do
    rect = Box.new(50, 50, 75) # Extends to [125, 125]

    rect.intersects_point?(62, 98).should == true
    rect.intersects_point?(130, 84).should_not == true
    rect.intersects_point?(79, 254).should_not == true
  end

end
