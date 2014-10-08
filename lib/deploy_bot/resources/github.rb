require_relative '../resource'
require 'openssl'
require 'multi_json'

module DeployBot
  module Resources
    class Github < Resource
      DIGEST = 'sha1'.freeze
      HMAC_DIGEST = OpenSSL::Digest.new(DIGEST)
      SECRET = ENV['GITHUB_SECRET']
      X_HUB_SIGNATURE = 'X-Hub-Signature'.freeze

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth)
        return false unless request.headers[X_HUB_SIGNATURE]
        signature = Hash[URI.decode_www_form(request.headers[X_HUB_SIGNATURE])][DIGEST]
        @body = request.body.to_s
        OpenSSL::HMAC.hexdigest(HMAC_DIGEST, SECRET, @body) == signature
      end

      def process_post
        payload = MultiJson.load(@body)
        true
      end
    end
  end
end
