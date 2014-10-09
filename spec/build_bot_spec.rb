require 'spec_helper'

describe BuildBot do
  include Webmachine::Test

  describe BuildBot::Utils do
    it 'Constantizes Strings' do
      expect(BuildBot::Utils::constantize('BuildBot::Utils')).to eq BuildBot::Utils
    end
  end

  let(:app) { BuildBot::Application }

  describe BuildBot::Application do
    it 'is a Webmachine::Application' do
      expect(described_class).to be_a Webmachine::Application
    end
  end

  describe BuildBot::Resource do
    include_context "default resource"

    it 'is a Webmachine::Resource' do
      expect(described_class.new(req, resp)).to be_a Webmachine::Resource
    end
  end

  describe BuildBot::Resources::Github do
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
