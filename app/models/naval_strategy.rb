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
    point = Point.from(point)
    x, y = point.to_a
    grid[x][y]
  end

  private

  def place_on_grid(deployment)
    deployment.vectors.each do |point|
      x, y = point.to_a
      grid[x][y] = deployment
    end
  end

  def grid
    @grid ||= Array.new(columns_count) { Array.new(rows_count) }
  end

  def columns_count
    10
  end

  def rows_count
    10
  end
end
