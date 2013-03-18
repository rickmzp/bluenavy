require_relative "../config/test_env"
require "rspec/autorun"

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
