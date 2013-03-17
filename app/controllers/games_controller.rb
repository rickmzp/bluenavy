class GamesController < ApplicationController
  def index
    @game = Game.new
  end

  def create
    game = Game.create_for_player(params[:game][:player_1])
    redirect_to game_url(id: game.id)
  rescue Mongoid::Errors::Validations => error
    @game = error.document
    render action: :index
  end

  def show
    #
  end

  protected

  helper_method :current_player
  def current_player
    current_game.player_1
  end

  helper_method :current_game
  def current_game
    @game = Game.find(params[:id])
  end
end
