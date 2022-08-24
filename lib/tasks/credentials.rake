namespace :env_creds do
  task :show, [:environment] do |_, args|
    env = args[:environment]
    if env.blank?
      system('bin/rails credentials:show')
    else
      env.downcase!
      file = "config/credentials/#{env}.yml.enc"
      key = "config/credentials/#{env}.key"
      system("bin/rails encrypted:show #{file} -k #{key}")
    end
  end

  task :edit, [:environment] do |_, args|
    ENV['EDITOR'] += ' --wait' if ENV['EDITOR'].present? && (ENV['EDITOR'] == 'code' || ENV['EDITOR'].ends_with?('/code')) # Stupid fix for vscode exiting too quickly
    env = args[:environment]
    if env.blank?
      system('bin/rails credentials:edit')
    else
      env.downcase!
      file = "config/credentials/#{env}.yml.enc"
      key = "config/credentials/#{env}.key"
      system("bin/rails encrypted:edit #{file} -k #{key}")
    end
  end
end
