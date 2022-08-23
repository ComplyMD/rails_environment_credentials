# frozen_string_literal: true

module RailsEnvironmentCredentials
  module Application
    extend ActiveSupport::Concern

    included do
      def credentials
        @credentials ||= encrypted(config.credentials.content_path, key_path: config.credentials.key_path, key: credentials_key)
      end

      def encrypted(path, key_path: 'config/master.key', env_key: 'RAILS_MASTER_KEY', key: nil)
        ActiveSupport::EncryptedConfiguration.new(
          config_path: Rails.root.join(path),
          key_path: Rails.root.join(key_path),
          env_key: env_key,
          key: key,
          raise_if_missing_key: config.require_master_key
        )
      end
    end

    def credentials_key_strategy
      @credentials_key_strategy ||= RailsEnvironmentCredentials::KeyStrategies.
        get(config.credentials.key_strategy).
        new(config.credentials.key_strategy_options)
    end

    def credentials_key
      @credentials_key ||= credentials_key_strategy.key
    end

  end
end
