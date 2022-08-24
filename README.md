# rails-environment-credentials

This gem expands the capabilities of `Rails.application.credentials` to support many different environments, as well as multiple ways to load the key.

By default, the credentials will be loaded from `config/credentials/#{Rails.env}.{yml.enc|.key}`, a different environment can be specified in the credentials config file.


## Show/Edit Credentials

`bin/rails env_creds:show\[some_special_environment\]`

`bin/rails env_creds:edit\[some_special_environment\]`


## Key Strategies

### nil/none/rails
This is the default strategy. Tthe key will be loaded the same way rails does it traditionally, by looking at the `RAILS_MASTER_KEY` environment variable, then from `config/credentials/some_environment.key`.

### raw
The key will be defined in the credentials config file.

Example `config/credentials.yml`:
```yaml
key_strategy: raw
key_strategy_options:
  key: 123abc456def789
```

### azure_key_vault_managed_identity
The key will be loaded from Azure Key Vault using an `access_token` from the VM's managed identity.

Example `config/credentials.yml`:
```yaml
key_strategy: azure_key_vault_managed_identity
key_strategy_options:
  vault: some-key-vault
  secret_name: some-environment-master-key
```


## Credentials Config File

It is recommended to keep this file in `.gitignore`

```yaml
environment: some-special-environment # Which environment credentials to load: `config/credentials/some-special-environment.yml.enc`

key_strategy: none|rails|raw|azure_key_vault_managed_identity # Which key strategy to use

key_strategy_options: # The options for the chosen key strategy
```
