source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'simplecov'
  gem 'metadata-json-lint'
  gem 'semantic_puppet'
  gem 'puppet-lint', '>= 2'
  gem 'puppet-lint-unquoted_string-check'
  gem 'puppet-lint-empty_string-check'
  gem 'puppet-lint-spaceship_operator_without_tag-check'
  gem 'puppet-lint-variable_contains_upcase'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-undef_in_function-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-file_ensure-check'
  gem 'puppet-blacksmith', '>= 3.1.0'

end

if facterversion = ENV['FACTER_VERSION']
  gem 'facter', facterversion
else
  gem 'facter'
end

if puppetversion = ENV['PUPPET_VERSION']
  gem 'puppet', puppetversion
else
  gem 'puppet'
end
