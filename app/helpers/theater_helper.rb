module TheaterHelper
  def new_attack_launcher
    render "attacks/launcher", attack: Attack.new
  end

  def render_theater(type, player)
    render "layouts/theater", {
      theater: player.send(type),
      type: type,
      player: player
    }
  end

  def render_theater_cell(cell)
    dom_classes = []
    dom_classes << "occupied" if cell.has_ship?
    if cell.attacked?
      dom_classes << "attacked"
      dom_classes << cell.attack.result
    end
    point_string = cell.point.to_sym.to_s.downcase
    dom_classes << point_string

    capture_haml do
      haml_tag :td, class: dom_classes, data: { point: point_string } do
        haml_concat cell.icon
      end
    end
  end
end
