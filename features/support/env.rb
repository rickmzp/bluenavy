require_relative "../../config/test_env"
require "cucumber/rails"

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation
FactoryGirl.find_definitions

World(FactoryGirl::Syntax::Methods)
