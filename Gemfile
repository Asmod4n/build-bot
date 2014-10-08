source 'https://rubygems.org'
source 'http://torquebox.org/4x/builds/gem-repo/'

gemspec

gem 'pry', group: :development

group :test do
  gem 'rack'
  gem 'rake'
  gem 'rspec'
end

platforms :ruby do
  gem 'yajl-ruby', require: 'yajl'
  gem 'yahns', group: :production
end

platforms :jruby do
  gem 'jrjackson'
  gem 'torquebox', '4.x.incremental.221', group: :production
end

gem 'multi_json'
gem 'webmachine'
gem 'webmachine-test'
