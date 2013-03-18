Given(/^it is my turn to attack in a game$/) do
  step "I create a game"
  step "an opponent joins the game"
  step "it must be my turn to attack"
end

When(/^I fire a missile at a grid point$/) do
  @grid_point = :A2
  within "#new_attack" do
    fill_in "Target", with: @grid_point
    click_button "Launch"
  end
  @attack = @game.reload.latest_attack
end

Then(/^a missle explodes at that grid point$/) do
  page.should have_css("#offensive_theater .#{@grid_point.to_s.downcase}.attacked")
end

Then(/^I receive a report on the attack's result$/) do
  page.should have_css("#attack_#{@attack.id}.completed")
end

Then(/^it is the enemy's turn to attack$/) do
  page.should have_css("#current_turn.player_2")
end

Then(/^it must be my turn to attack$/) do
  page.should have_css(".ready_to_attack")
end

Given(/^it is the enemy's turn to attack in a game$/) do
  step "it is my turn to attack in a game"
  step "I fire a missile at a grid point"
end

When(/^the enemy fires a missile at a grid point occupied by my navy$/) do
  my_ships_point = current_player.ship_deployments.first.vectors.first
  @attack = current_player.opponent.attack(my_ships_point)
end

When(/^the enemy fires a missile at an empty grid point$/) do
  empty_point = current_player.offensive.any_empty_cell.point
  @attack = current_player.opponent.attack(empty_point)
end

Then(/^I receive a report of their attack's success$/) do
  reload_page
  page.should have_css("#attack_#{@attack.id}.completed")
  page.should have_css("#defensive_theater .#{@attack.target.to_sym.to_s.downcase}.attacked.hit")
end

Then(/^I receive a report of their attack's failure$/) do
  reload_page
  page.should have_css("#attack_#{@attack.id}.completed")
  page.should have_css("#defensive_theater .#{@attack.target.to_sym.to_s.downcase}.attacked.miss")
end
