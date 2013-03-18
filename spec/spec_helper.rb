require_relative "../config/test_env"
require "rspec/autorun"

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.infer_base_class_for_anonymous_controllers = false
  c.order = "random"
end
