Given(/^the enemy's navy is at their last stand$/) do
  step "a game I created has started"
  PlaySimulator.play_until_last_stand_for(current_player.opponent, @game)
end

Given(/^my navy is at its last stand$/) do
  step "a game I created has started"
  PlaySimulator.play_until_last_stand_for(current_player, @game)
end

Given(/^it is my turn to attack$/) do
  step "it must be my turn to attack"
end

When(/^I fire a missle at their last remaining offensive$/) do
  point = current_player.opponent.defensive.any_controlled_cell.point
  step "I fire a missile at grid point #{point.to_sym}"
end

When(/^the enemy fires a missle at my last remaining offensive$/) do
  step "the enemy fires a missile at a grid point occupied by my navy"
end

Then(/^I am declared the winner$/) do
  page.should have_css(".game_result.you_win")
end

Then(/^I am declared the loser$/) do
  page.should have_css(".game_result.you_lose")
end
