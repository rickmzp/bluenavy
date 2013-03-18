# encoding: utf-8
module AuthenticationHelpers
  def sign_in_as(name)
    visit "/"
    fill_in "Name", with: name
    click_button "Sign In"
  end
end

World(AuthenticationHelpers)

Before do
  @my_name = Faker::Name.name
  sign_in_as @my_name
end

When(/^I create a game$/) do
  within "#new_game" do
    fill_in "Name", with: @my_name
    click_button "Create Game"
  end
end

Then(/^I start waiting for an opponent to join$/) do
  page.should have_css(".waiting_for_an_opponent")
end

Given(/^a player has created a game$/) do
  @game = create(:game)
end

When(/^I join the game$/) do
  visit root_path
  within "#game_#{@game.id}" do
    fill_in "Name", with: @my_name
    click_button "Join"
  end
end

Then(/^the game begins$/) do
  page.should have_css(".waiting_for_attack")
end

Given(/^the game I'm in has begun$/) do
  @game = create(:game)
  @enemy = @game.player_1
  step "I join the game"
  save_and_open_page
end

When(/^I deploy my navy$/) do
  save_and_open_page
  click_button "Auto-deploy"
end

When(/^declare I am ready for war$/) do
  click_button "Begin Attack"
end

Then(/^I get to attack first$/) do
  page.should have_css(".ready_to_attack")
end

Given(/^the enemy has deployed their navy$/) do
  @enemy.navy.deploy
end

Then(/^the enemy gets to attack first$/) do
  page.should have_content "Waiting for Opponent's Attack"
end
