require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'bundler/gem_tasks'

gemspec = Gem::Specification.load('build_bot.gemspec')
Gem::PackageTask.new(gemspec)
RSpec::Core::RakeTask.new(:spec)
task default: :spec
