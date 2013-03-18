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
    "A: #{deployments.first.class.inspect}"
  end

  def attack
    deployment_of_type(Attack)
  end

  def attacked?
    attack.present?
  end

  def ship_deployment
    deployment_of_type(ShipDeployment)
  end

  def ship
    ship_deployment.try(:ship)
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

  private

  def deployment_of_type(type)
    deployments.select do |deployment|
      deployment.is_a?(type)
    end.first
  end
end
