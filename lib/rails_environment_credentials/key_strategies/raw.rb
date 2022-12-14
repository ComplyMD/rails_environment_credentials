# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies

    class Raw < Base

      def key
        Rails.application.config.credentials.key_strategy_options['key']
      end

    end

    add(:raw, Raw)

  end
end
