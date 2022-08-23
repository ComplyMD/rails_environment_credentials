# frozen_string_literal: true

module RailsEnvironmentCredentials
  module EncryptedConfiguration
    extend ActiveSupport::Concern

    included do
      def initialize(config_path:, key_path:, env_key:, raise_if_missing_key:, key: nil)
        super(content_path: config_path, key_path: key_path, env_key: env_key, raise_if_missing_key: raise_if_missing_key, key: key)
      end
    end

  end
end
