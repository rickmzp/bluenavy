class Game
  include Mongoid::Document

  class << self
    def create_for_user(user)
      game = new
      game.player_1 = Player.from_user(user)
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
  validates :player_1,
    presence: { if: :started? }

  def player_named(name)
    case name
    when player_1.try(:name) then player_1
    when player_2.try(:name) then player_2
    else raise "No player named: #{name}"
    end
  end

  def join(user)
    player = Player.from_user(user)
    update_attributes! player_2: player
    player
  end

  field :started, type: Boolean, default: false
  validates :started,
    inclusion: { in: [true, false] }

  def start
    raise "already started" if started?
    self.current_turn = :player_1
    update_attributes! started: true
  end

  field :current_turn, type: Symbol
  validates :current_turn,
    inclusion: { in: [:player_1, :player_2], allow_nil: true },
    presence: { if: :started? }

  def player_with_current_turn
    send(current_turn) if current_turn.present?
  end

  private

  def player_sym(player)
    if player.present?
      return :player_1 if player_1 == player
      return :player_2 if player_2 == player
    end
    raise "unknown player: #{player}"
  end
end
