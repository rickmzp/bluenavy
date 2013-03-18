module GridHelper
  def render_cell(cell)
    dom_classes = []
    dom_classes << "attacked" if cell.attacked?
    dom_classes << cell.point.to_sym.to_s.downcase

    capture_haml do
      haml_tag :td, class: dom_classes do
        haml_concat cell.icon
      end
    end
  end
end
