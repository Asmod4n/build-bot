require_relative 'monkey_patching'
require 'sodium'
require 'webmachine'
require 'multi_json'
require 'sprockets'

module BuildBot
end

require_relative 'build_bot/version'
require_relative 'build_bot/utils'
require_relative 'build_bot/application'
require_relative 'build_bot/resource'
require_relative 'build_bot/resources'
