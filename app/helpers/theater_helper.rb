module TheaterHelper
  def new_attack_launcher
    render "attacks/launcher", attack: Attack.new
  end

  def render_theater(type, player)
    render "layouts/theater", theater: player.send(type), type: type
  end

  def render_theater_cell(cell)
    dom_classes = []
    dom_classes << "occupied" if cell.has_ship?
    if cell.attacked?
      dom_classes << "attacked"
      dom_classes << cell.attack.result
    end
    dom_classes << cell.point.to_sym.to_s.downcase

    capture_haml do
      haml_tag :td, class: dom_classes do
        haml_concat cell.icon
      end
    end
  end
end
