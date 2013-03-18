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

  def vectors
    [target]
  end
end
