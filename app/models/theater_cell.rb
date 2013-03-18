class TheaterCell
  def initialize(point, theater, deployments = [])
    @point = point
    @theater = theater
    @deployments = deployments
  end

  attr_reader :point

  attr_reader :theater

  attr_reader :deployments

  def deploy(deployment)
    deployments << deployment
  end

  def name
    "hello"
  end

  def attacked?
    false
  end

  def ship
    deployments.first.try(:ship)
  end

  def has_ship?
    ship.present?
  end

  def empty?
    ship.blank?
  end

  def icon
    ship ? ship.name.first : "?"
  end
end
