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
