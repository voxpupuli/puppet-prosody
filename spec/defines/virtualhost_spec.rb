require 'spec_helper'
require 'erb'

describe 'prosody::virtualhost' do
  let(:title) { 'mockvirtualhost' }

  before :each do
    # This will be useful for rendering the template cleanly/easily
    @name = title
    @ensure = 'present'
  end

  def render_template
    path = File.expand_path(File.dirname(__FILE__) + "/../../templates/virtualhost.cfg.erb")
    ERB.new(File.read(path), 0, "-").result(binding)
  end

  context 'with no parameters' do
    it {
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :path    => "/etc/prosody/conf.avail/#{title}.cfg.lua",
        :content => render_template,
        :notify  => 'Service[prosody]',
      )
    }

    it {
      should contain_file("/etc/prosody/conf.d/#{title}.cfg.lua").with(
        :ensure  => 'link',
        :target  => "/etc/prosody/conf.avail/#{title}.cfg.lua",
        :require => "File[#{title}.cfg.lua]",
        :notify  => 'Service[prosody]',
      )
    }
  end

  context 'with ssl_key but no ssl_cert' do
    let(:params) { {:ssl_key => 'bananas' } }
    it {
      expect {
        should contain_class('prosody')
      }.to raise_error(Puppet::Error)
    }
  end

  context 'with ssl_cert but no ssl_key' do
    let(:params) { {:ssl_cert => 'bananas' } }
    it {
      expect {
        should contain_class('prosody')
      }.to raise_error(Puppet::Error)
    }
  end

  context 'with ssl keys and certs' do
    let(:ssl_key) { '/etc/prosody/certs/rspec-puppet.com.key' }
    let(:ssl_cert) { '/etc/prosody/certs/rspec-puppet.com.crt' }
    let(:params) { { :ssl_key => ssl_key, :ssl_cert => ssl_cert } }

    before :each do
      @ssl_key = ssl_key
      @ssl_cert = ssl_cert
    end

    it {
      # This require statment is bananas
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :content => render_template,
        :require => ["File[#{ssl_key}]", "File[#{ssl_cert}]", 'Class[Prosody::Package]']
      )
    }
  end

  context 'ensure => absent' do
    let(:params) { { :ensure => 'absent' } }
    it {
      @ensure = 'absent'
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => @ensure,
        :content => render_template
      )
    }

    it {
      should contain_file("/etc/prosody/conf.d/#{title}.cfg.lua").with_ensure('absent')
    }
  end
end
