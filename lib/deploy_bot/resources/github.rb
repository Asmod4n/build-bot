require 'webmachine/resource'
require 'multi_json'

module DeployBot
  class GithubResource < Webmachine::Resource
    def allowed_methods
      [:POST.to_s]
    end

    def content_types_accepted
      [[:"application/json".to_s, :from_json]]
    end

    def process_post
      payload = MultiJson.load(request.body.to_s)
      true
    end

    private

    def from_json; end
  end
end
