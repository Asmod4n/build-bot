require 'spec_helper'

describe BuildBot do
  describe BuildBot::VERSION do
    it 'is a Gem::Version' do
      expect(described_class).to be_a Gem::Version
    end
  end

  describe BuildBot::Utils do
    it 'Constantizes Strings' do
      expect(BuildBot::Utils::constantize('BuildBot::Utils')).to eq BuildBot::Utils
    end
  end

  describe BuildBot::Application do
    it 'is a Webmachine::Application' do
      expect(described_class).to be_a Webmachine::Application
    end
  end

  describe BuildBot::Resource do
    include_context 'webmachine/resource'
    it 'is a Webmachine::Resource' do
      expect(described_class.new(req, resp)).to be_a Webmachine::Resource
    end
  end

  describe BuildBot::Resources::Github do
    include_context 'webmachine/app'
    it 'processes JSON' do
      payload = '{}'
      signature = OpenSSL::HMAC.hexdigest(described_class::HMAC_DIGEST, described_class::SECRET, payload)
      header(described_class::X_HUB_SIGNATURE, "#{described_class::HMAC_DIGEST.name.downcase}=#{signature}")
      body(Array(payload))
      post('/github')
      expect(response.body).to be_nil
      expect(response.code).to eq 204
    end
  end

  describe BuildBot::Resources::Travis do
    include_context 'webmachine/app'
    it 'processes JSON' do
      header('Authorization', Digest::SHA2.hexdigest("#{described_class::REPOSITORY}#{described_class::TRAVIS_TOKEN}"))
      body(URI.encode_www_form(payload: '{}'))
      post('/travis')
      expect(response.body).to be_nil
      expect(response.code).to eq 204
    end
  end
end
