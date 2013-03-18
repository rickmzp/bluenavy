#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require "cucumber/rake/task"
require "rspec/core/rake_task"

BlueNavy::Application.load_tasks
Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new

Rake::Task["default"].clear
task :default => [:spec, :cucumber]
