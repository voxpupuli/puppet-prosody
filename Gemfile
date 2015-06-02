source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'rspec-puppet'
  gem 'puppetlabs_spec_helper'
  gem 'serverspec'
  gem 'puppet-lint'
  gem 'simplecov'
  gem 'beaker'
  gem 'beaker-rspec'
  gem 'rspec'
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion
else
  gem 'facter'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion
else
  gem 'puppet'
end
