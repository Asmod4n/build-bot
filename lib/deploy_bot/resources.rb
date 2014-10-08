require_relative 'application'
require_relative 'utils'

module DeployBot
  Application.routes do
    Dir.chdir(File.expand_path('../resources', __FILE__)) do
      Dir['*.rb'].each do |resource|
        require_relative "resources/#{resource}"
        path = File.basename(resource, '.rb')
        add [path], Utils.constantize("DeployBot::Resources::#{path.capitalize}")
      end
    end
  end
end
