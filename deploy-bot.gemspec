$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'deploy_bot/version'

Gem::Specification.new do |gem|
  gem.author       = 'Hendrik Beskow'
  gem.description  = 'deploy_bot'
  gem.summary      = gem.description
  gem.homepage     = 'https://github.com/Asmod4n/deploy-bot'
  gem.license      = 'Apache-2.0'

  gem.name         = 'deploy_bot'
  gem.files        = Dir['README.md', 'LICENSE', 'lib/**/*']
  gem.test_files   = Dir['spec/**/*']
  gem.version      = DeployBot::VERSION

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'bundler', '>= 1.7'
end