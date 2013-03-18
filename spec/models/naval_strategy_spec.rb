require "spec_helper"

describe NavalStrategy do
  it "can place a ship on the grid" do
    ship = build(:ship, size: 4)
    strategy = NavalStrategy.new
    strategy.deploy_ship(ship, :B2, :vertical)
    expect(strategy.at(:A2)).to be_empty
    expect(strategy.at(:B2)).to have_ship(ship)
    expect(strategy.at(:C2)).to have_ship(ship)
    expect(strategy.at(:D2)).to have_ship(ship)
    expect(strategy.at(:E2)).to have_ship(ship)
    expect(strategy.at(:F2)).to be_empty
  end

  describe ".generate" do
    it "returns a NavalStrategy with deployed ships" do
      navy = build(:navy)
      strategy = NavalStrategy.generate_for(navy)
      expect(strategy.deployments.length).to eq(5)
    end
  end
end

RSpec::Matchers.define :have_ship do |ship|
  match do |cell|
    cell.has_ship? && cell.ship == ship
  end
end
