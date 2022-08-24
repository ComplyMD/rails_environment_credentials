require 'rails'

module RailsEnvironmentCredentials
  class Railtie < Rails::Railtie
    railtie_name :rails_environment_credentials

    rake_tasks do
      load 'tasks/credentials.rake'
    end

  end
end
