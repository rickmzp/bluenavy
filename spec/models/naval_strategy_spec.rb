require "spec_helper"

describe NavalStrategy do
  it "can place a ship horizontally on the grid" do
    strategy = NavalStrategy.new
    ship = strategy.deploy_ship(:aircraft_carrier, :B2, :h)
    expect(strategy.ship_at(:B1)).to be(nil)
    expect(strategy.ship_at(:B2)).to be(ship)
    expect(strategy.ship_at(:B3)).to be(ship)
    expect(strategy.ship_at(:B4)).to be(ship)
    expect(strategy.ship_at(:B5)).to be(ship)
    expect(strategy.ship_at(:B6)).to be(ship)
    expect(strategy.ship_at(:B7)).to be(nil)
  end
end
