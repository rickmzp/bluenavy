class Player
  include Mongoid::Document

  def self.from_user(user)
    player = new
    player.user = user
    player
  end

  embedded_in :game, inverse_of: :player_1
  embedded_in :game, inverse_of: :player_2

  field :user, type: User
  validates :user,
    presence: true

  def name
    user.name
  end

  def to_s
    name
  end

  embeds_one :navy
  after_initialize :build_navy_if_nil

  def has_turn?
    game.has_turn?(self)
  end

  def waiting_for_turn?
    !has_turn?
  end

  def attack(point)
    game.attack_by(self, target: point)
  end

  def offensive
    Theater.with_deployments(attacks)
  end

  def defensive
    Theater.with_deployments(ship_deployments + opponent.attacks)
  end

  def ship_deployments
    navy.strategy.deployments
  end

  def opponent
    game.opponent_to(self)
  end

  def attacks
    game.attacks_by(self)
  end

  def to_sym
    player_in_game
  end

  private

  def player_in_game
    return :player_1 if game.player_1 == self
    return :player_2 if game.player_2 == self
    raise "Unknown player"
  end

  def build_navy_if_nil
    build_navy if navy.nil?
  end
end
