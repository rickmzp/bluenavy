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

Given(/^I have created a game$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^an opponent joins the game$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the game begins$/) do
  pending # express the regexp above with the code you wish you had
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
