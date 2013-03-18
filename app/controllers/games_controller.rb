class GamesController < ApplicationController
  def index
    @new_game = Game.new
    @games = Game.all
  end

  def create
    self.current_player = params[:game][:player_1]
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
    self.current_player = params[:game][:player_2]
    current_game.join(current_player)
    current_game.start
    redirect_to current_game
  end

  protected

  helper_method :current_player
  def current_player
    raise "current_player not set" unless session.has_key?(:current_player)
    session[:current_player]
  end

  def current_player=(player)
    raise "current_player cannot be blank" if player.blank?
    session[:current_player] = player
  end

  helper_method :current_game
  def current_game
    @game = Game.find(params[:id])
  end

  helper_method :opponent
  def opponent
    if current_player == current_game.player_1
      current_game.player_2
    else
      current_game.player_1
    end
  end
end
