class Navy
  include Mongoid::Document
  embedded_in :player

  def deploy(strategy = nil)
    if strategy.nil?
      self.strategy = NavalStrategy.generate_for(self)
    else
      self.strategy = true
    end
  end

  def ship_at(*args)
    strategy.ship_at(*args)
  end

  def grid
    strategy.grid
  end

  embeds_one :strategy, class_name: "NavalStrategy"

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
end
