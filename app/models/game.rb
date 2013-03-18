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

  field :player_1, type: String
  validates :player_1,
    presence: true

  field :player_2, type: String
  validates :player_1,
    presence: { if: :started? }

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
