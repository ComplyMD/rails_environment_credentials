# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies
    @map = {}.with_indifferent_access

    class << self
      attr_reader :map

      def get(strategy)
        map[strategy] || raise("CredentialsKeyStrategy unknown strategy: #{strategy}")
      end

      def add(name, klass)
        map[name] = klass
      end

    end

  end
end

require 'rails_environment_credentials/key_strategies/base'
require 'rails_environment_credentials/key_strategies/none'
require 'rails_environment_credentials/key_strategies/raw'
require 'rails_environment_credentials/key_strategies/azure_key_vault_managed_identity'
