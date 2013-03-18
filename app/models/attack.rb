class Attack < Deployment
  def self.launch_on(target)
    new(target: target)
  end

  embedded_in :game, inverse_of: :attacks

  field :target, type: Point
  attr_accessible :target

  field :player_sym, type: Symbol
  attr_accessible :player_sym
  validates :player_sym,
    inclusion: { in: [:player_1, :player_2] }

  def player
    game.send(player_sym)
  end

  alias_method :successful?, :persisted?
  alias_method :completed?, :persisted?

  def hit?
    player.opponent.defensive.at(target).has_ship?
  end

  def miss?
    !hit?
  end

  def result
    hit? ? :hit : :miss
  end

  def vectors
    [target]
  end
end
