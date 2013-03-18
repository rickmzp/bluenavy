module ApplicationHelper
  def render_navy(navy)
    render "layouts/grid", navy: navy
  end
end
