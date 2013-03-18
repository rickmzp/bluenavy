class Theater
  include Mongoid::Document
  include GridSupport

  class << self
    alias_method :with_deployments, :new
  end

  def initialize(deployments = [])
    super()
    self.deployments = deployments
  end

  after_initialize :place_deployments_on_grid

  embedded_in :navy, inverse_of: :strategy

  embeds_many :deployments, class_name: "ShipDeployment"

  def height
    rows.count
  end

  def width
    columns.count
  end

  def deploy_ship(ship, start_point, direction)
    deployment = ShipDeployment.new(ship, Point.from(start_point), direction)
    ensure_deployment_fits(deployment)
    place_on_grid(deployment)
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

  def at(point)
    x, y = Point.from(point).to_a
    grid[x][y]
  end

  private

  def ensure_deployment_fits(deployment)
    deployment.vectors.each do |point|
      cell = at(point)
      raise ShipConflict.new(cell) if cell.has_ship?
    end
  end

  def place_deployments_on_grid
    deployments.each do |deployment|
      place_on_grid(deployment)
    end
  end

  def place_on_grid(deployment)
    deployment.vectors.each do |point|
      x, y = point.to_a
      grid[x][y].deploy(deployment)
    end
  end

  def grid
    @grid ||= Array.new(columns_count) do |x|
      Array.new(rows_count) do |y|
        TheaterCell.new(Point.at(x, y), self)
      end
    end
  end

  def columns_count
    10
  end

  def rows_count
    10
  end

  class InvalidDeployment < Exception
  end

  class ShipConflict < InvalidDeployment
    def initialize(cell)
      @cell = cell
    end

    attr_reader :cell
  end
end
