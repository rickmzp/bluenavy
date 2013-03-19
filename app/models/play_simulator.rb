class PlaySimulator
  def self.play_until_last_stand_for(player, game)
    new(game).play_until_last_stand_for(player)
  end

  def initialize(game)
    @game = game
  end

  def play_until_last_stand_for(loser)
    winner = loser.opponent

    begin
      current_player = @game.player_with_turn
      strategy = (current_player == winner ? :win : :lose)
      play_strategy_for(current_player, strategy)
    end until loser.last_stand? && winner.has_turn?
  end

  private

  def play_strategy_for(player, strategy)
    cell_type = (strategy == :win ? :controlled : :empty)
    cell = player.opponent.defensive.send("any_#{cell_type}_cell")
    player.attack(cell.point)
  end
end
