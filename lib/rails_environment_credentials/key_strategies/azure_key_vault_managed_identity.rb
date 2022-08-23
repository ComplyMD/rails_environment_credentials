# frozen_string_literal: true

module RailsEnvironmentCredentials
  module KeyStrategies

    class AzureKeyVaultManagedIdentity < Base

      def access_token
        response = HTTParty.get( # rubocop:disable Style/RescueModifier
          'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net',
          {
            headers: { Metadata: 'true' },
            timeout: 1,
            open_timeout: 1,
            read_timeout: 1,
          }
        ) rescue nil
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity access_token: unable to get' unless response
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity access_token: unable to parse response' unless response.parsed_response.is_a?(Hash)
        token = response.parsed_response['access_token']
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity access_token: fetch failed' unless token.present?
        token
      end

      def vault_url
        @vault_url ||= if options.key?(:vault_url)
                         options[:vault_url]
                       elsif options[:vault]
                         "https://#{options[:vault]}.vault.azure.net/"
                       else
                         raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity vault_url: must supply either vault or vault_url'
                       end
      end

      def secret_name
        @secret_name ||= if options.key?(:secret_name)
                           options[:secret_name]
                         else
                           raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity secret_name: must supply secret_name'
                         end
      end

      def secret_url
        @secret_url ||= if options.key?(:secret_url)
                          options[:secret_url]
                        else
                          "#{vault_url}/secrets/#{secret_name}?api-version=2016-10-01"
                        end
      end

      def key
        response = HTTParty.get( # rubocop:disable Style/RescueModifier
          secret_url,
          {
            headers: { Authorization: "Bearer #{access_token}" },
            timeout: 1,
            open_timeout: 1,
            read_timeout: 1,
          }
        ) rescue nil
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity key: unable to get secret' unless response
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity key: unable to parse response' unless response.parsed_response.is_a?(Hash)
        secret = response.parsed_response['value']
        raise 'CredentialsKeyStrategy AzureKeyVaultManagedIdentity key: fetch failed' unless secret.present?
        secret
      end

    end

    add(:azure_key_vault_managed_identity, AzureKeyVaultManagedIdentity)

  end
end
