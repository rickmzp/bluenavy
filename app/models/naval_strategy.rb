class NavalStrategy
  include Mongoid::Document

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

  def initialize(deployments = [])
    super()
    self.deployments = deployments
  end

  after_initialize :place_deployments_on_grid

  embedded_in :navy, inverse_of: :strategy

  embeds_many :deployments, class_name: "ShipDeployment"

  def deploy_ship(ship, start_point, direction)
    deployment = ShipDeployment.new(ship, Point.from(start_point), direction)
    deployments << deployment
    deployment
  end

  def randomly_deploy_ship(ship)
    Rails.logger.info "random"
    # TODO: expand grid
    point = Point.from([rand(5), rand(5)])
    direction = (rand(2) == 1 ? :horizontal : :vertical)
    deploy_ship(ship, point, direction)
  end

  def ship_at(point)
    point = Point.from(point)
    x, y = point.to_a
    grid[x][y]
  end

  private

  def place_deployments_on_grid
    deployments.each do |deployment|
      place_on_grid(deployment)
    end
  end

  def place_on_grid(deployment)
    deployment.vectors.each do |point|
      x, y = point.to_a
      Rails.logger.info [x, y]
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
