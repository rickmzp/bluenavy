class Navy
  include Mongoid::Document
  embedded_in :player

  def deploy(strategy)
    self.strategy = true
  end

  attr_reader :strategy

  def deployed?
    strategy.present?
  end

  def ships
    [
      Ship.named("Aircraft Carrier", 5),
      Ship.named("Battleship", 4),
      Ship.named("Submarine", 3),
      Ship.named("Destroyer", 3),
      Ship.named("Patrol Boat", 2)
    ]
  end

  private

  attr_writer :strategy
end
