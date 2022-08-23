# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies
    class Base
      attr_reader :options

      def initialize(opts = {})
        @options = (opts || {}).with_indifferent_access
      end

      def key
        nil
      end

    end
  end
end
