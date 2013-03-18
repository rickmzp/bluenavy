module ApplicationHelper
  def render_navy(navy)
    render_theater(navy.strategy)
  end

  def render_theater(theater)
    render "layouts/grid", theater: theater
  end

  def new_attack_launcher
    render "attacks/launcher", attack: Attack.new
  end
end
