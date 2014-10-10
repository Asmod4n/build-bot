require_relative '../resource'
require 'digest/sha2'
require 'sodium'
require 'uri'
require 'multi_json'

module BuildBot
  module Resources
    class Travis < Resource
      TRAVIS_TOKEN = ENV['TRAVIS_TOKEN'].freeze
      DIGEST = Digest::SHA2.hexdigest("Asmod4n/build-bot#{TRAVIS_TOKEN}").freeze
      DIGEST_SIZE = DIGEST.bytesize.freeze

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth)
        return false unless auth
        puts auth
        DIGEST_SIZE == auth.bytesize && Sodium.memcmp(DIGEST, auth, DIGEST_SIZE) == 0
      end

      def process_post
        if request.has_body?
          body = Hash[URI.decode_www_form(request.body.to_s)]
          puts MultiJson.load(body['payload'])
          true
        else
          400
        end
      rescue MultiJson::ParseError
        400
      end
    end
  end
end
