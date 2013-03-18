class NavalStrategy < Theater
  class << self
    def generate_for(navy)
      strategy = new
      ships_to_deploy = navy.ships.dup

      begin
        begin
          strategy.randomly_deploy_ship ships_to_deploy.last
          ships_to_deploy.pop
        rescue Theater::InvalidDeployment
          # do nothing, allow script to try again
        end
      end until ships_to_deploy.empty?

      strategy
    end
  end

  alias_method :ship_at, :at
end
