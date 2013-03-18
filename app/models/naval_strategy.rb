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

  alias_method :ship_at, :at
end
