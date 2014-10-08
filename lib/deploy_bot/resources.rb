require_relative 'application'
Dir["#{File.expand_path('../resources', __FILE__)}/*"].each do |resource|
  require resource
end

module DeployBot
  Application.routes do
    add ['github'], GithubResource
  end
end
