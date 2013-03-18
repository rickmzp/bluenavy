class NavalStrategy < Theater
  class << self
    def generate_for(navy)
      strategy = new
      ships_to_deploy = navy.ships.dup

      attempts = 0
      begin
        begin
          strategy.randomly_deploy_ship ships_to_deploy.last
          ships_to_deploy.pop
        rescue Theater::InvalidDeployment
          attempts += 1
          ensure_not_looping_too_much(attempts)
        end
      end until ships_to_deploy.empty?

      strategy
    end

    def ensure_not_looping_too_much(count)
      if count > 500
        raise "too many attempts to try to place ships"
      end
    end
  end

  include Mongoid::Document

  def initialize(deployments = [])
    super(deployments: deployments)
  end

  after_initialize :place_deployments_on_grid

  embedded_in :navy, inverse_of: :strategy

  embeds_many :deployments, class_name: "Deployment"
  attr_accessible :deployments

  alias_method :ship_at, :at

  def deploy_ship(ship, start_point, direction)
    deployment = ShipDeployment.new(ship, Point.from(start_point), direction)
    ensure_deployment_fits(deployment)
    deploy(deployment)
  end

  def randomly_deploy_ship(ship)
    # TODO: expand grid
    point = Point.from([rand(5), rand(5)])
    direction = (rand(2) == 1 ? :horizontal : :vertical)
    deploy_ship(ship, point, direction)
  end
end
