require 'bundler/setup'
require 'webmachine/test'
require 'build_bot'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  if defined?(::Java)
    config.seed = Time.now.utc
  else
    config.order = :random
  end
end

shared_context 'webmachine/app' do
  include Webmachine::Test
  let(:app) { BuildBot::Application }
end

shared_context 'webmachine/resource' do
  let(:method) { 'GET' }
  let(:uri) { URI.parse('http://localhost/') }
  let(:headers) { Webmachine::Headers.new }
  let(:body) { '' }
  let(:req) { Webmachine::Request.new(method, uri, headers, body) }
  let(:resp) { Webmachine::Response.new }
  let(:resource_class) do
    Class.new(BuildBot::Resource) do
      def to_html
        '<html><body>Hello, world!</body></html>'
      end
    end
  end
  let(:resource) { resource_class.new(req, resp) }
end
