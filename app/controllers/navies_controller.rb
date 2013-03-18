class NaviesController < ApplicationController
  def auto_deploy
    navy.deploy NavalStrategy.generate_for(navy)
    redirect_to :back
  end

  def navy
    current_player.navy
  end
end
