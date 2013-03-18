class NavalStrategy
  def self.generate_for(navy)
    strategy = new
    ships_to_deploy = navy.ships.dup

    begin
      begin
        strategy.randomly_deploy_ship ships_to_deploy.last
        ships_to_deploy.pop
      rescue InvalidDeployment
      end
    end until ships_to_deploy.empty?

    strategy
  end

  class InvalidDeployment < Exception
  end

  def deployments
    @deplyoments ||= []
  end

  def deploy_ship(ship, start_point, direction)
    deployment = ShipDeployment.new(ship, Point.from(start_point), direction)
    deployments << deployment
    place_on_grid(deployment)
    deployment
  end

  def randomly_deploy_ship(ship)
    point = Point.from([rand(9), rand(9)])
    direction = (rand(1) == 1 ? :horizontal : :vertical)
    deploy_ship(ship, point, direction)
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
