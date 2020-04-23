# this includes speed.  is this the right name?
# should this include HP?  if tasks cause damage, it should
class Coordinates
  attr_accessor :x, :y, :a, :vel_x, :vel_y, :vel_a

  def initialize(x:, y:, a:, vel_x:, vel_y:, vel_a:)
    @x = x.to_f
    @y = y.to_f
    @a = a.to_f
    @vel_x = vel_x.to_f
    @vel_y = vel_y.to_f
    @vel_a = vel_a.to_f
  end
end
