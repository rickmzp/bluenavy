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
end

Then(/^a missle explodes at that grid point$/) do
  page.should have_css("#opposing_grid .#{@grid_point.to_s.downcase}.attacked")
end

Then(/^I receive a report on the attack's result$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it is the enemy's turn to attack$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it must be my turn to attack$/) do
  page.should have_css(".ready_to_attack")
end
