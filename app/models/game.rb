class Game
  include Mongoid::Document

  class << self
    def create_for_user(user)
      game = new
      game.player_1 = Player.from_user(user)
      game.player_1.navy.deploy
      game.save!
      game
    end

    alias_method :create, :create!
  end

  embeds_one :player_1, class_name: "Player"
  validates :player_1,
    presence: true

  alias_method :creator, :player_1

  embeds_one :player_2, class_name: "Player"

  def started?
    player_2.present?
  end

  def player_named(name)
    case name
    when player_1.try(:name) then player_1
    when player_2.try(:name) then player_2
    else raise "No player named: #{name}"
    end
  end

  def join(user)
    player = Player.from_user(user)
    player.navy.deploy
    update_attributes! player_2: player
    player_2
  end

  field :current_turn, type: Symbol, default: :player_1
  validates :current_turn,
    inclusion: { in: [:player_1, :player_2] }

  def player_with_turn
    send(current_turn)
  end

  alias_method :player_with_current_turn, :player_with_turn

  def player_sym(player)
    if player.present?
      return :player_1 if player_1 == player
      return :player_2 if player_2 == player
    end
    raise "unknown player: #{player}"
  end

  embeds_many :attacks

  def attack_by(player, options)
    raise OutOfTurn if not has_turn?(player)
    attack = attacks.create!({ player_sym: player_sym(player) }.merge(options))
    player.offensive.deploy(attack)
    player.opponent.defensive.deploy(attack)
    save!
    change_turn
    attack
  end

  def attacks_by(player)
    attacks.where(player_sym: player_sym(player))
  end

  def latest_attack
    attacks.last
  end

  def has_turn?(player)
    player_with_current_turn == player
  end

  def opponent_to(player)
    return player_2 if player == player_1
    return player_1 if player == player_2
    raise "unknown error"
  end

  private

  def change_turn
    return change_turn_to(:player_2) if current_turn == :player_1
    return change_turn_to(:player_1) if current_turn == :player_2
    raise "unknown error"
  end

  def change_turn_to(player_sym)
    update = update_attributes! current_turn: player_sym
    send_pusher_event(:turn_change, player: player_sym)
    update
  end

  def send_pusher_event(event, data = {})
    return if not ENV.has_key?("PUSHER_SECRET")
    Pusher.trigger("game_#{id}_events", event, data)
  end

  class OutOfTurn < Exception
  end
end
