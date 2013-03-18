class ShipDeployment
  def initialize(ship, start_point, direction)
    @ship = ship
    @start_point = Point.new(start_point)
    @direction = direction
  end

  attr_reader :ship

  attr_reader :start_point

  attr_reader :direction

  def vectors
    to_change = (direction == :horizontal ? :x : :y)
      case direction
      when :horizontal then :x
      when :vertical then :y
      else raise "unknown direction: #{direction}"
      end

    ship.size.times.collect do |i|
      next start_point if i == 0
      start_point.send("change_#{to_change}", i)
    end
  end
end
