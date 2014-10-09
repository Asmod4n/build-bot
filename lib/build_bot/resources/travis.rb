require_relative '../resource'
require 'uri'
require 'multi_json'

module BuildBot
  module Resources
    class Travis < Resource
      def allowed_methods
        [:POST.to_s]
      end

      def process_post
        body = URI.decode_www_form(request.body.to_s)
        puts MultiJson.load(body['payload'])
        true
      end
    end
  end
end
