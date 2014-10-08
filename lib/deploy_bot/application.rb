require 'webmachine/application'
require 'webmachine/adapter'
require 'webmachine/adapters/rack'

module DeployBot
  Application = Webmachine::Application.new do |app|
    app.configure do |config|
      config.adapter = :Rack
    end
  end
end
