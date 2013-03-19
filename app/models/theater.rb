class Theater
  include GridSupport

  class << self
    alias_method :with_deployments, :new
  end

  def initialize(deployments = [])
    @deployments = deployments
    place_deployments_on_grid
  end

  attr_reader :deployments

  def height
    rows.count
  end

  def width
    columns.count
  end

  def deploy(deployment)
    place_on_grid(deployment)
    deployments << deployment
    deployment
  end

  def at(point)
    x, y = Point.from(point).to_a
    grid[x][y]
  end

  def any_controlled_cell
    each_cell do |cell|
      return cell if cell.controlled?
    end
    nil
  end

  def controlled_cells
    cells.select do |cell|
      cell.controlled?
    end
  end

  def any_empty_cell
    each_cell do |cell|
      return cell if cell.empty?
    end
    nil
  end

  def each_cell
    cells.each do |cell|
      yield(cell)
    end
  end

  def cells
    grid.flatten
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
