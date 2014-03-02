require 'gosu'

class Point < Struct.new(:x, :y); end

module Rect
  attr_accessor :origin, :width, :height

  def includes?(other_rect)
    if right >= x && bottom >= y
      x <= other_rect.x && right >= other_rect.right && bottom >= other_rect.bottom && y <= other_rect.y 
    elsif right < x && bottom >= y
      right <= other_rect.x && x >= other_rect.right && bottom >= other_rect.bottom && y <= other_rect.y 
    elsif right >= x && bottom < y
      x <= other_rect.x && right >= other_rect.right && bottom <= other_rect.y && y > other_rect.bottom 
    elsif right < x && bottom < y
      right <= other_rect.x && x >= other_rect.right && bottom <= other_rect.y && y > other_rect.bottom
    end
  end

  def x
    @origin.x
  end

  def y
    @origin.y
  end

  def right
    x + width
  end

  def bottom
    y + height
  end
end

class Selection
  include Rect
  
  def initialize(origin)
    @origin, @end = origin, origin
    @width, @height = 0, 0
  end

  def end=(end_point)
    @width = end_point.x - x
    @height = end_point.y - y
  end
end

class Unit
  include Rect
  Size = 15
  Speed = 1

  attr_accessor :selected, :destination

  def initialize(origin)
    @origin = origin
    @width, @height = Size, Size
    @selected = false
  end

  def update
    if @destination && @origin != @destination
      if @destination.x > @origin.x
        @origin.x += Speed
      elsif @destination.x < @origin.x
        @origin.x -= Speed
      end

      if @destination.y > @origin.y
        @origin.y += Speed
      elsif @destination.y < @origin.y
        @origin.y -= Speed
      end
    end
  end

  def color
    @selected ? Gosu::Color::GREEN : Gosu::Color::WHITE
  end

  def draw(window)
    window.draw_quad  x, y, color,
                      x + Size, y, color,
                      x, y + Size, color,
                      x + Size, y + Size, color
  end
end

class GameWindow < Gosu::Window
  include Gosu
  attr_reader :width, :height

  def initialize(width, height)
    super(width, height, false)
    self.caption = "#{fps} FPS"
    @width, @height = width, height

    @units = [Unit.new(Point.new(200, 200))]
  end

  def button_down(id)
    if id == MsLeft
      unless @selection
        @selection = Selection.new(mouse_point)
      end
    end

    if id == MsRight
      move_to = mouse_point
      @units.each do |unit|
        unit.destination = move_to if unit.selected
      end
    end

    exit if id == KbEscape
  end

  def button_up(id)
    @selection = nil if id == MsLeft
  end

  def update
    @units.each { |unit| unit.update }

    if @selection
      @selection.end = mouse_point

      @units.each do |unit|
        unit.selected = @selection.includes?(unit)
      end
    end
  end

  def draw
    draw_cursor

    if @selection
      selection_color = Gosu::Color.argb(0xccff0000)
      draw_quad @selection.x, @selection.y, selection_color,
                @selection.right, @selection.y, selection_color,
                @selection.x, @selection.bottom, selection_color,
                @selection.right, @selection.bottom, selection_color
    end

    @units.each { |u| u.draw(self) }
  end

  private
  def draw_cursor
    size = 2
    cursor = Gosu::Color.argb(0xffffffff)
    draw_quad mouse_x - (size/2), mouse_y - (size/2), cursor,
              mouse_x + size, mouse_y - (size/2), cursor,
              mouse_x - (size/2), mouse_y + size, cursor,
              mouse_x + size, mouse_y + size, cursor
  end

  def mouse_point
    Point.new(mouse_x.to_i, mouse_y.to_i)
  end

end

GameWindow.new(640, 480).show
