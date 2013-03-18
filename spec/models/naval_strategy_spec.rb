require "spec_helper"

describe NavalStrategy do
  it "can place a ship on the grid" do
    ship = double(size: 4)
    strategy = NavalStrategy.new
    ship = strategy.deploy_ship(ship, :B2, :vertical)
    expect(strategy.ship_at(:A2)).to eq(nil)
    expect(strategy.ship_at(:B2)).to eq(ship)
    expect(strategy.ship_at(:C2)).to eq(ship)
    expect(strategy.ship_at(:D2)).to eq(ship)
    expect(strategy.ship_at(:E2)).to eq(ship)
    expect(strategy.ship_at(:F2)).to eq(nil)
  end

  describe ".generate" do
    it "returns a NavalStrategy with deployed ships" do
      navy = build(:navy)
      strategy = NavalStrategy.generate_for(navy)
      expect(strategy.deployments.length).to eq(5)
    end
  end
end
