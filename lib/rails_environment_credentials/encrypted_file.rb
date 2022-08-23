# frozen_string_literal: true

module RailsEnvironmentCredentials
  module EncryptedFile
    extend ActiveSupport::Concern

    included do
      def initialize(content_path:, key_path:, env_key:, raise_if_missing_key:, key: nil)
        @content_path = Pathname.new(content_path)
        @key_path = Pathname.new(key_path)
        @env_key = env_key
        @raise_if_missing_key = raise_if_missing_key
        @key = key unless key.nil?
      end

      def key
        @key || read_env_key || read_key_file || handle_missing_key
      end
    end

  end
end
