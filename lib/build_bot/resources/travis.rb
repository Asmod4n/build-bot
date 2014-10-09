require_relative '../resource'
require 'digest/sha2'
require 'uri'
require 'multi_json'

module BuildBot
  module Resources
    class Travis < Resource
      TRAVIS_TOKEN = ENV['TRAVIS_TOKEN']

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth)
        return false unless auth
        puts auth
        Digest::SHA2.hexdigest("Asmod4n/build-bot#{TRAVIS_TOKEN}") == auth
      end

      def process_post
        body = Hash[URI.decode_www_form(request.body.to_s)]
        puts MultiJson.load(body['payload'])
        true
      end
    end
  end
end
