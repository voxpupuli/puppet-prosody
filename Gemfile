source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :development, :test do
  gem 'metadata-json-lint'
  gem 'puppet-blacksmith', '>= 3.1.0'
  gem 'puppet-lint', '>= 2'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-empty_string-check'
  gem 'puppet-lint-file_ensure-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-spaceship_operator_without_tag-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-undef_in_function-check'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-variable_contains_upcase'
  gem 'puppetlabs_spec_helper'
  gem 'rake'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'semantic_puppet'
  gem 'simplecov'
end

if ENV['FACTER_VERSION']
  gem 'facter', ENV['FACTER_VERSION']
else
  gem 'facter' # rubocop:disable Bundler/DuplicatedGem
end

if ENV['PUPPET_VERSION']
  gem 'puppet', ENV['PUPPET_VERSION']
else
  gem 'puppet' # rubocop:disable Bundler/DuplicatedGem
end
