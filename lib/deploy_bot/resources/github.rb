require_relative '../resource'
require 'multi_json'

module DeployBot
  module Resources
    class Github < Resource
      def allowed_methods
        [:POST.to_s]
      end

      def process_post
        puts MultiJson.load(request.body.to_s)
        true
      end
    end
  end
end
