class Game
  include Mongoid::Document

  class << self
    def create_for_player(player)
      game = new
      game.player_1 = player
      game.save!
      game
    end

    alias_method :create, :create!
  end

  embeds_one :player_1, class_name: "Player"
  validates :player_1,
    presence: true

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

  def join(player)
    self.player_2 = player
    save!
    self
  end

  field :started, type: Boolean, default: false
  validates :started,
    inclusion: { in: [true, false] }

  def start
    update_attributes! started: true
  end
end
