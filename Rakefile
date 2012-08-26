require 'rake'

require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --fail-fast'
  t.pattern = 'spec/*/*_spec.rb'
end

Cucumber::Rake::Task.new(:cucumber)
