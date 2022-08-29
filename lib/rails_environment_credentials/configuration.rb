# frozen_string_literal: true

module RailsEnvironmentCredentials
  class CredentialsConfig < ActiveSupport::OrderedOptions

    def environment
      super || default_credentials_environment
    end

    def content_path
      super || default_credentials_content_path
    end

    def key_path
      super || default_credentials_key_path
    end

    private

      def default_credentials_environment
        ENV.fetch('RAILS_CREDENTIALS_ENV') { Rails.env }
      end

      def default_credentials_content_path
        Rails.root.join('config', 'credentials', "#{environment}.yml.enc")
      end

      def default_credentials_key_path
        Rails.root.join('config', 'credentials', "#{environment}.key")
      end

  end

  module Configuration
    extend ActiveSupport::Concern

    included do
      attr_accessor :credentials
    end

    def initialize(*)
      super
      @credentials = CredentialsConfig.new
      @credentials.merge! credentials_config
      
    end

    private

      def credentials_config
        path = root.join('config/credentials.yml')
        @credentials_config ||= (path.exist? ? YAML.safe_load(path.read) : {}).symbolize_keys
      end

  end
end
