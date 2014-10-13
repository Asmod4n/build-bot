﻿require_relative '../resource'
require 'openssl'
require 'uri'
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

      def allowed_methods
        [:POST.to_s]
      end

      def is_authorized?(auth = nil)
        return false unless request.headers[X_HUB_SIGNATURE] =~ DIGEST_MATCH
        signature = $1
        if request.has_body?
          digest = OpenSSL::HMAC.new(SECRET, HMAC_DIGEST)
          request.body.each do |body|
            digest << body
          end
          digest = digest.hexdigest
          digest.bytesize == signature.bytesize && Sodium::memcmp(digest, signature, digest.bytesize) == 0
        else
          400
        end
      rescue ArgumentError
        400
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
