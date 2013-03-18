module GridHelper
  def render_cell(cell)
    dom_classes = []
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
