class GamesController < ApplicationController
  def index
    @new_game = Game.new
    @games = Game.all
  end

  def create
    game = Game.create_for_user(current_user)
    self.current_player = :player_1
    redirect_to game_path(id: game.id)
  rescue Mongoid::Errors::Validations => error
    @new_game = error.document
    render action: :index
  end

  def join
    current_game.join(current_user)
    self.current_player = :player_2
    redirect_to current_game
  end

  def ready_to_play
    current_player.ready!
    redirect_to current_game
  end

  def url_options
    current_game.present? ? super.merge(game_id: current_game) : super
  end

  private

  def sign_in_player(name)
    self.current_player = Player.named(name)
  end
end
