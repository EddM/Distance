class EntityWithDepth < Entity

  attr_reader :distance
  
  def initialize(x, y, distance, width = 32, height = 58)
    super(x, y, width, height)
    @distance = distance
  end

end
