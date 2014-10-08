require 'spec_helper'

describe DeployBot do
  include Webmachine::Test

  let(:app) { DeployBot::Application }

  describe DeployBot::Application do
    it 'is a Webmachine::Application' do
      expect(app).to be_a Webmachine::Application
    end
  end

  describe DeployBot::Resources::Github do
    it 'processes JSON' do
      body('{}')
      post('/github')
      expect(response.body).to be_nil
      expect(response.code).to eq 204
    end
  end
end
