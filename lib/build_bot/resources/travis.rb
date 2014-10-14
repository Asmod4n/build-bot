require_relative '../resource'
require 'digest/sha2'
require 'sodium'
require 'uri'
require 'multi_json'

module BuildBot
  module Resources
    class Travis < Resource
      REPOSITORY = ENV['REPOSITORY'].freeze
      TRAVIS_TOKEN = ENV['TRAVIS_TOKEN'].freeze
      DIGEST = FFI::MemoryPointer.from_string(Digest::SHA2::hexdigest("#{REPOSITORY}#{TRAVIS_TOKEN}"))
      CONTENT_TYPE = 'application/x-www-form-urlencoded'.freeze

      def allowed_methods
        [:POST.to_s]
      end

      def known_content_type?(content_type = nil)
        content_type == CONTENT_TYPE
      end

      def is_authorized?(authorization_header = nil)
        return false unless authorization_header
        puts authorization_header
        DIGEST.size - 1 == authorization_header.bytesize && Sodium::memcmp(DIGEST, authorization_header, DIGEST.size) == 0
      end

      def process_post
        body = Hash[URI::decode_www_form(request.body.to_s)]
        puts MultiJson::load(body['payload'])
        true
      rescue ArgumentError, MultiJson::ParseError
        400
      end
    end
  end
end
