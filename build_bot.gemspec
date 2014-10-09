$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'build_bot/version'

Gem::Specification.new do |gem|
  gem.author       = 'Hendrik Beskow'
  gem.description  = 'build_bot'
  gem.summary      = gem.description
  gem.homepage     = 'https://github.com/Asmod4n/deploy-bot'
  gem.license      = 'Apache-2.0'

  gem.name         = 'build_bot'
  gem.files        = Dir['README.md', 'LICENSE', 'config.ru', 'lib/**/*']
  gem.test_files   = Dir['spec/**/*']
  gem.version      = BuildBot::VERSION

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'rack', '>= 1.5.2'
  gem.add_dependency 'webmachine', '>= 1.2.2'
  gem.add_dependency 'multi_json', '>= 1.10.1'
  gem.add_dependency 'ffi-libsodium', '>= 0.0.8'
  gem.add_dependency 'rake'
  gem.add_development_dependency 'rspec', '>= 3.1.0'
  gem.add_development_dependency 'webmachine-test', '>= 0.2.1'
end
