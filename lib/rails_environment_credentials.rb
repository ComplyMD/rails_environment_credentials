# frozen_string_literal: true

# Container Module
module RailsEnvironmentCredentials; end

require 'active_support/concern'

require 'rails_environment_credentials/application'
require 'rails_environment_credentials/configuration'
require 'rails_environment_credentials/encrypted_configuration'
require 'rails_environment_credentials/encrypted_file'
require 'rails_environment_credentials/key_strategies'
require 'rails_environment_credentials/version'

Rails::Application::Configuration.send(:include, RailsEnvironmentCredentials::Configuration)
Rails::Application.send(:include, RailsEnvironmentCredentials::Application)
ActiveSupport::EncryptedConfiguration.send(:include, RailsEnvironmentCredentials::EncryptedConfiguration)
ActiveSupport::EncryptedFile.send(:include, RailsEnvironmentCredentials::EncryptedFile)
