﻿require 'faraday/http_cache'
require 'typhoeus/adapters/faraday'
require 'octokit'
require_relative '../resource'
require 'openssl'
require 'multi_json'

Octokit.middleware = Faraday::RackBuilder.new do |builder|
  builder.use :http_cache
  builder.use Octokit::Response::RaiseError
  builder.adapter :typhoeus
end

$octokit = Octokit::Client.new(:access_token => ENV['OCTOKIT_ACCESS_TOKEN'])

module BuildBot
  module Resources
    class Github < Resource
      DIGEST = 'sha1'.freeze
      HMAC_DIGEST = OpenSSL::Digest.new(DIGEST)
      SECRET = ENV['GITHUB_SECRET']
      X_HUB_SIGNATURE = 'x-hub-signature'.freeze
      X_GITHUB_EVENT = 'x-github-event'.freeze


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
        @payload = MultiJson.load(@body)
        case request.headers[X_GITHUB_EVENT]
        when 'pull-request'
          if @payload['action'] == 'opened'
            process_pull_request
          end
        end
        true
      end

      private

      def process_pull_request
        $octokit.create_status(@payload['pull_request']['base']['repo']['full_name'], @payload['pull_request']['head']['sha'], 'pending')
        puts system "rake"

        $octokit.create_status(@payload['pull_request']['base']['repo']['full_name'], @payload['pull_request']['head']['sha'], 'success')
      end
    end
  end
end