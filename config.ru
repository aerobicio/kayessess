require 'rubygems'
require 'bundler'
require 'rails'

Bundler.require :default, :development

Combustion.initialize! :action_controller, :action_view, :sprockets
run Combustion::Application
