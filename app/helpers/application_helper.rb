module ApplicationHelper
  def render_navy(navy)
    render "layouts/grid", navy: navy
  end

  def new_attack_launcher
    render "attacks/launcher", attack: Attack.new
  end
end
