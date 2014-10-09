require_relative '../resource'
require 'openssl'
require 'sodium'
require 'multi_json'

module BuildBot
  module Resources
    class Github < Resource
      DIGEST = 'sha1'.freeze
      HMAC_DIGEST = OpenSSL::Digest.new(DIGEST)
      SECRET = ENV['GITHUB_SECRET'].freeze
      X_HUB_SIGNATURE = 'x-hub-signature'.freeze
      X_GITHUB_EVENT = 'x-github-event'.freeze

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth)
        return false unless request.headers[X_HUB_SIGNATURE]
        signature = Hash[URI.decode_www_form(request.headers[X_HUB_SIGNATURE])][DIGEST]
        @body = request.body.to_s
        digest = OpenSSL::HMAC.hexdigest(HMAC_DIGEST, SECRET, @body)
        digest.bytesize == signature.bytesize && Sodium.memcmp(digest, signature, digest.bytesize) == 0
      rescue ArgumentError
        400
      end

      def process_post
        @payload = MultiJson.load(@body)
        puts request.headers[X_GITHUB_EVENT]
        puts @payload
        true
      rescue MultiJson::ParseError
        400
      end
    end
  end
end
