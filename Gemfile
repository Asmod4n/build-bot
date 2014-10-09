source 'https://rubygems.org'
source 'http://torquebox.org/4x/builds/gem-repo/'
gemspec

group :development do
  gem 'pry'
end

group :test do
  gem 'rake'
  gem 'rspec'
  gem 'webmachine-test'
end

group :production do
  platforms :ruby do
    gem 'yajl-ruby', require: 'yajl'
    gem 'yahns'
  end

  platforms :jruby do
    gem 'jrjackson'
    gem 'torquebox', '4.x.incremental.221'
  end
end
