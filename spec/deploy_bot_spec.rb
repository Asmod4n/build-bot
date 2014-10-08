require 'spec_helper'

describe DeployBot do
  include Webmachine::Test

  describe DeployBot::Utils do
    describe '::constantize' do
      it 'Constantizes Strings' do
        expect(DeployBot::Utils::constantize('DeployBot::Utils')).to eq DeployBot::Utils
      end
    end
  end

  let(:app) { DeployBot::Application }

  describe DeployBot::Application do
    it 'is a Webmachine::Application' do
      expect(described_class).to be_a Webmachine::Application
    end
  end

  describe DeployBot::Resource do
    include_context "default resource"

    it 'is a Webmachine::Resource' do
      expect(described_class.new(req, resp)).to be_a Webmachine::Resource
    end
  end

  describe DeployBot::Resources::Github do
    it 'processes JSON' do
      bod = '{}'
      signature = OpenSSL::HMAC.hexdigest(described_class::HMAC_DIGEST, described_class::SECRET, bod)
      header(described_class::X_HUB_SIGNATURE, "#{described_class::DIGEST}=#{signature}")
      body(bod)
      post('/github')
      expect(response.body).to be_nil
      expect(response.code).to eq 204
    end
  end
end
