class NavalStrategy
  def self.generate
    new
  end

  def deploy_ship(type, start_point, direction)
    @ship_deployments ||= []
    deployment = ShipDeployment.new(type, Point.new(start_point), direction)
    @ship_deployments << deployment
    place_on_grid(deployment)
    deployment
  end

  def ship_at(point)
    grid(point_to_grid_index_path(point))
  end

  private

  def place_on_grid(deployment)
    deployment.vectors.each do |x, y|
      grid[x][y]
    end
  end

  def grid
    @grid ||= Array.new(columns_count) { Array.new(rows_count) }
  end

  def rows_count
    10
  end

  def rows_count
    10
  end
end
