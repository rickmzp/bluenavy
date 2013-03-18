require "spec_helper"

describe NavalStrategy do
  it "can place a ship on the grid" do
    ship = double(size: 4)
    strategy = NavalStrategy.new
    ship = strategy.deploy_ship(ship, :B2, :horizontal)
    expect(strategy.ship_at(:B1)).to eq(nil)
    expect(strategy.ship_at(:B2)).to eq(ship)
    expect(strategy.ship_at(:B3)).to eq(ship)
    expect(strategy.ship_at(:B4)).to eq(ship)
    expect(strategy.ship_at(:B5)).to eq(ship)
    expect(strategy.ship_at(:B6)).to eq(nil)
  end
end
