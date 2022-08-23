# frozen_string_literal: true

module RailsEnvironmentCredentials
  module Configuration
    extend ActiveSupport::Concern

    included do
      attr_accessor :credentials
    end

    def initialize(*)
      super
      @credentials = ActiveSupport::OrderedOptions.new
      @credentials.merge! credentials_config
      @credentials.environment ||= default_credentials_environment
      @credentials.content_path ||= default_credentials_content_path
      @credentials.key_path ||= default_credentials_key_path
    end

    private

      def credentials_config
        path = root.join('config/credentials.yml')
        @credentials_config ||= (path.exist? ? YAML.safe_load(path.read) : {}).symbolize_keys
      end

      def default_credentials_environment
        ENV.fetch('RAILS_CREDENTIALS_ENV') { Rails.env }
      end

      def default_credentials_content_path
        root.join('config', 'credentials', "#{credentials.environment}.yml.enc")
      end

      def default_credentials_key_path
        root.join('config', 'credentials', "#{credentials.environment}.key")
      end

  end
end
