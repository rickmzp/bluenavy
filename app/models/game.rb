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
end
