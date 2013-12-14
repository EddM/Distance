class Projectile

  GravitationalVelocity = 9.81

  # Initial speed of projectile, in m/s
  def velocity
    800
  end

  # Angle, in degrees, relative to horizontal
  def angle
    5
  end
  
  # Maximum distance travelled by projectile based on a given
  # initial speed and angle, given no air resistance
  def distance
    ((velocity ** 2) * Math.sin(2 * ((angle * Math::PI) / 180))) / GravitationalVelocity
  end

end


describe Projectile do

  it "calculates maximum range" do
    @projectile = Projectile.new
    @projectile.distance.to_i.should == 11328
  end

end
