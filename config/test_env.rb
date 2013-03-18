ENV["RAILS_ENV"] ||= 'test'
require_relative "environment"
require "rspec/rails"
FactoryGirl.find_definitions
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
