# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'rails_environment_credentials/version'

Gem::Specification.new do |s|
  s.name        = 'rails_environment_credentials'
  s.version     = RailsEnvironmentCredentials::VERSION
  s.authors     = ['Taylor Yelverton']
  s.email       = 'rubygems@yelvert.io'
  s.homepage    = 'https://github.com/ComplyMD/rails_environment_credentials'
  s.summary     = 'Add support for different credentials for different environments to Rails'
  s.license     = 'MIT'
  s.description = 'Add support for different credentials for different environments to Rails'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/ComplyMD/rails_environment_credentials/issues',
    'changelog_uri' => 'https://github.com/ComplyMD/rails_environment_credentials/commits/master',
    'documentation_uri' => 'https://github.com/ComplyMD/rails_environment_credentials/wiki',
    'homepage_uri' => 'https://github.com/ComplyMD/rails_environment_credentials',
    'source_code_uri' => 'https://github.com/ComplyMD/rails_environment_credentials',
    'rubygems_mfa_required' => 'true',
  }

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z -- {lib/**/*,README.md,MIT-LICENSE,rails_environment_credentials.gemspec}`.
      split("\x0")
  end

  s.require_paths = %w[ lib ]

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency('activesupport', '>= 5.0.0')
  s.add_dependency('railties', '>= 5.0.0')
end
