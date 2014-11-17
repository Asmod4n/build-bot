require 'webmachine/resource'

module BuildBot
  class Resource < Webmachine::Resource
    ALLOWED_METHODS = [:POST.to_s].freeze

    def allowed_methods
      ALLOWED_METHODS
    end
  end
end
