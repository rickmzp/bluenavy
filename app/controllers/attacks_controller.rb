class AttacksController < ApplicationController
  def create
    point = Point.from(params[:target])
    current_player.attack(point)
    redirect_to current_game
  end
end
