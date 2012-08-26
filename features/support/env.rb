require 'fileutils'

require 'rubygems'
require 'blimpy'


module Prosody
  module World
    def resources
      # Resources should be an Array of strings that will be joined together to
      # make the full Puppet node manifest that will be provisioned on the host
      @resources ||= []
    end

    def work_dir
      File.expand_path(File.dirname(__FILE__) + "/../../tmp/cucumber")
    end

    def manifest_path
      File.join(work_dir, 'manifests')
    end

    def modules_path
      File.join(work_dir, 'modules')
    end

    def setup_work_dir
      # We can't set this up unless we've already "remembered" our original
      # directory
      expect(@original_dir).to_not be_nil

      FileUtils.mkdir_p(manifest_path)
      FileUtils.mkdir_p(File.join(modules_path, 'modules', 'prosody'))
      FileUtils.ln_s(File.join(@original_dir, 'manifests'), File.join(modules_path, 'prosody', 'manifests'))
    end
  end
end


World(Prosody::World)


Before do
  @original_dir = Dir.pwd

  unless File.exists?(work_dir)
    FileUtils.mkdir_p(work_dir)
  end

  Dir.chdir(work_dir)

  setup_work_dir
end

After do
  unless @fleet.nil?
    @fleet.destroy
  end

  Dir.chdir(@original_dir)
  # Nuke the temporary working directory after we're all finished
  FileUtils.rm_rf(work_dir)
end
