class EntityWithDepth < Entity

  attr_reader :distance
  
  def initialize(x, y, distance, width = 50, height = 50)
    super(x, y, width, height)
    @distance = distance
  end

end
