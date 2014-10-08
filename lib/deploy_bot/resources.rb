require_relative 'application'
Dir["#{File.expand_path('../resources', __FILE__)}/*"].each do |resource|
  require resource
end

module DeployBot
  module Resources
    Application.routes do
      add ['github'], Github
    end
  end
end
