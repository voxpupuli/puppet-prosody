source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'serverspec'
  gem 'puppet-lint'
  gem 'simplecov'
  gem 'rspec'
  gem 'metadata-json-lint'
  gem 'semantic_puppet'
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
