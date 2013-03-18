class Player < Struct.new(:name, :game)
  include Mongoid::Document

  def self.named(name)
    player = new
    player.name = name
    player
  end

  embedded_in :game

  field :name, type: String
  validates :name,
    presence: true

  def to_s
    name
  end

  embeds_one :navy

  after_initialize :build_navy_if_nil

  def ready!
    game.ready!(self)
  end

  def ready_to_attack?
    game.player_with_current_turn == self
  end

  def waiting_for_opponent?
    !ready_to_attack?
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
