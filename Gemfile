source 'https://rubygems.org'
gemspec
gem 'pry'

platforms :ruby do
  gem 'yajl-ruby', require: 'yajl'
  gem 'therubyracer'
end

platforms :jruby do
  gem 'jrjackson'
  java_version = Gem::Version.new(java.lang.System.getProperties['java.specification.version'])
  if java_version < Gem::Version.new('1.8')
    gem 'therubyrhino'
  end
end
