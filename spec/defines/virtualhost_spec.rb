require 'spec_helper'
require 'erb'

describe 'prosody::virtualhost' do
  let(:title) { 'mockvirtualhost' }
  let(:facts) {
    {
      :operatingsystem => 'Ubuntu'
    }
  }

  before :each do
    # This will be useful for rendering the template cleanly/easily
    @name = title
    @ensure = 'present'
    @ssl_key = 'UNSET'
    @ssl_cert = 'UNSET'
  end

  it { should include_class 'prosody' }

  def render_template
    path = File.expand_path(File.dirname(__FILE__) + "/../../templates/virtualhost.cfg.erb")
    ERB.new(File.read(path)).result(binding)
  end

  context 'with no parameters' do
    it {
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :content => render_template
      )
    }
  end

  context 'with ssl_key but no ssl_cert' do
    let(:params) { {:ssl_key => 'bananas' } }
    it {
      expect {
        should include_class('prosody')
      }.to raise_error(Puppet::Error)
    }
  end

  context 'with ssl_cert but no ssl_key' do
    let(:params) { {:ssl_cert => 'bananas' } }
    it {
      expect {
        should include_class('prosody')
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
        :require => ["File[#{ssl_key}]", "File[#{ssl_cert}]"]
      )
    }
  end

  context 'ensure => absent' do
    let(:params) { { :ensure => 'absent' } }
    it {
      @ensure = 'absent'
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :content => render_template
      )
    }
  end
end
