require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'bundler/gem_tasks'

Gem::PackageTask.new(Gem::Specification.load('build_bot.gemspec'))
RSpec::Core::RakeTask.new(:spec)
task default: :spec
