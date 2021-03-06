class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  protected

  helper_method :current_navy
  def current_navy
    current_player.navy
  end

  helper_method :current_player
  def current_player
    return if not session.has_key?(:current_player)
    current_game.try(:send, session[:current_player])
  end

  def current_player=(player)
    raise "current_player cannot be blank" if player.blank?
    session[:current_player] = player
  end

  helper_method :current_game
  def current_game
    return unless params.has_key?(:game_id) || params.has_key?(:id)
    @game = Game.find(params[:game_id] || params[:id])
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
