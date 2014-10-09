require_relative '../resource'
require 'digest/sha2'
require 'uri'
require 'multi_json'

module BuildBot
  module Resources
    class Travis < Resource
      TRAVIS_TOKEN = ENV['TRAVIS_TOKEN']
      AUTHORIZATION = 'Authorization'.freeze

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth)
        return false unless request.headers[AUTHORIZATION]
        Digest::SHA2.hexdigest("Asmod4n/build-bot#{TRAVIS_TOKEN}") == request.headers[AUTHORIZATION]
      end

      def process_post
        body = Hash[URI.decode_www_form(request.body.to_s)]
        puts MultiJson.load(body['payload'])
        true
      end
    end
  end
end
