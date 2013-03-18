require_relative "../../config/test_env"
require "cucumber/rails"

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation
FactoryGirl.find_definitions
MiniTest::Spec.new(nil)

World(FactoryGirl::Syntax::Methods)
World(MiniTest::Assertions)
