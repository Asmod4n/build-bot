require_relative '../resource'
require 'openssl'
require 'sodium'
require 'multi_json'

module BuildBot
  module Resources
    class Github < Resource
      DIGEST_MATCH = /^sha1=([0-9a-f]{40})$/.freeze
      HMAC_DIGEST = OpenSSL::Digest.new('sha1')
      SECRET = ENV['GITHUB_SECRET'].freeze
      X_HUB_SIGNATURE = 'x-hub-signature'.freeze
      X_GITHUB_EVENT = 'x-github-event'.freeze
      CONTENT_TYPE = 'application/json'.freeze
      ALLOWED_METHODS = [:POST.to_s].freeze

      def allowed_methods
        ALLOWED_METHODS
      end

      def malformed_request?
        return true unless (match = DIGEST_MATCH.match(request.headers[X_HUB_SIGNATURE]))
        @signature = match[1]
        false
      end

      def known_content_type?(content_type = nil)
        content_type == CONTENT_TYPE
      end

      def is_authorized?(auth = nil)
        digest = OpenSSL::HMAC.new(SECRET, HMAC_DIGEST)
        request.body.each do |body|
          digest << body
        end
        digest = digest.hexdigest
        digest.bytesize == @signature.bytesize && Sodium::memcmp(digest, @signature, digest.bytesize) == 0
      end

      def process_post
        @payload = MultiJson::load(request.body.to_s)
        puts request.headers[X_GITHUB_EVENT]
        puts @payload
        true
      rescue MultiJson::ParseError
        400
      end
    end
  end
end
