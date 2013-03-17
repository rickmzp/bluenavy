require 'minitest/spec'
World(MiniTest::Assertions)
MiniTest::Spec.new(nil)

require 'cucumber/rails'

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation
