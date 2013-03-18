class GamesController < ApplicationController
  def index
    @new_game = Game.new
    @games = Game.all
  end

  def create
    sign_in_player(params[:game][:player_1])
    game = Game.create_for_player(current_player)
    redirect_to game_path(id: game.id)
  rescue Mongoid::Errors::Validations => error
    @new_game = error.document
    render action: :index
  end

  def show
    #
  end

  def join
    sign_in_player(params[:game][:player_2])
    current_game.join(current_player)
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
