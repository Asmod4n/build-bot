require 'webmachine/resource'
require 'multi_json'

module DeployBot
  module Resources
    class Github < Webmachine::Resource
      def allowed_methods
        [:POST.to_s]
      end

      def process_post
        MultiJson.load(request.body.to_s)
        true
      end
    end
  end
end
