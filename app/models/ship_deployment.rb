class ShipDeployment
  include Mongoid::Document
  extend Forwardable

  embedded_in :grid, inverse_of: :deployments

  def initialize(ship, start_point, direction)
    super()
    self.ship = ship
    self.start_point = Point.from(start_point)
    self.direction = direction
  end

  embeds_one :ship
  validates :ship,
    presence: true

  def_delegator :ship, :name

  field :start_point, type: Point
  validates :start_point,
    presence: true

  field :direction, type: Symbol
  validates :direction,
    inclusion: { in: [:horizontal, :vertical] }

  def vectors
    to_change =
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
