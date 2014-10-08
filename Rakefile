require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'bundler/gem_tasks'

def gemspec
	$gemspec ||= Gem::Specification.load("deploy-bot.gemspec")
end

Gem::PackageTask.new(gemspec) do |pkg|
	pkg.need_zip = false
	pkg.need_tar = false
end

task :gem => :gemspec

desc %{Validate the gemspec file.}
task :gemspec do
	gemspec.validate
end

desc %{Release the gem to RubyGems.org}
task release: :gem do
	system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
end

desc "Run specs"
RSpec::Core::RakeTask.new(:spec)

task default: :spec
