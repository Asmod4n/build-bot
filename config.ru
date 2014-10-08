require 'bundler/setup'
require 'build_bot'

run BuildBot::Application.adapter
