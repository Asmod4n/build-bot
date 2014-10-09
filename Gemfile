source 'https://rubygems.org'
source 'http://torquebox.org/4x/builds/gem-repo/'
gemspec

gem 'pry', group: :development

group :test do
  gem 'rake'
  gem 'rspec'
  gem 'webmachine-test'
end

platforms :ruby do
  gem 'yajl-ruby', require: 'yajl'
  gem 'yahns', group: :production
end

platforms :jruby do
  gem 'jruby-openssl'
  gem 'jrjackson'
  gem 'torquebox', '4.x.incremental.221', group: :production
end

gem 'octokit'
gem 'rack'
gem 'webmachine'
gem 'multi_json'
