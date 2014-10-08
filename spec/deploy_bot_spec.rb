require 'spec_helper'

describe DeployBot::Application do
  include Webmachine::Test

  let(:app) { DeployBot::Application }

  describe 'DeployBot::Application' do
    it 'is a Webmachine::Application' do
      expect(app).to be_a Webmachine::Application
    end
  end
end
