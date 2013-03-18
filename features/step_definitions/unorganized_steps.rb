# encoding: utf-8
Before do
  @my_name = Faker::Name.name
end

When(/^I create a game$/) do
  visit "/"

  within "#new_game" do
    fill_in "Name", with: @my_name
    click_button "Create Game"
  end
end

Then(/^I start waiting for an opponent to join$/) do
  page.must have_content("Welcome, #{@my_name}! Waiting for an opponent…")
end

Given(/^a player has created a game$/) do
  @game = create(:game)
end

When(/^I join the game$/) do
  visit "/"

  within "#game_#{@game.id}" do
    fill_in "Name", with: @my_name
    click_button "Join"
  end
end

Then(/^the game begins$/) do
  page.must have_content("Welcome, #{@my_name}! The game with #{@game.player_1} is now beginning…")
end

Given(/^the game has begun$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I deploy my navy$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^declare I am ready for war$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I get to attack first$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^the enemy has deployed their navy$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the enemy gets to attack first$/) do
  pending # express the regexp above with the code you wish you had
end
