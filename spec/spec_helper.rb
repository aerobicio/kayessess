ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require_relative 'use_coveralls' if ENV['TRAVIS']
  require_relative 'use_simplecov'
end

require 'bundler/setup'
require 'combustion'
require 'rails'
require 'kayessess'

Combustion.initialize! :action_controller, :action_view, :sprockets

require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |config|
  config.order = "random"
end
