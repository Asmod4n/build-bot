require_relative '../resource'
require 'uri'
require 'multi_json'

module DeployBot
  module Resources
    class Travis < Resource
      def allowed_methods
        [:POST.to_s]
      end

      def process_post
        payload = URI.decode_www_form(request.body.to_s)
        puts MultiJson.load(payload['payload'])
        true
      end
    end
  end
end
