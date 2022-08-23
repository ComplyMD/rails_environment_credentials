# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies

    class Raw < Base

      def key
        Rails.application.config.credentials.raw_key
      end

    end

    add(:raw, Raw)

  end
end
