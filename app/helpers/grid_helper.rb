module GridHelper
  def render_point(point)
    dom_classes = []
    dom_classes << "attacked" if point.attacked?

    capture_haml do
      haml_tag :td, class: dom_classes do
        haml_concat point.name
      end
    end
  end
end
