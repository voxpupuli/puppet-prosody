require 'spec_helper'
require 'erb'

describe 'prosody::virtualhost' do
  let(:pre_condition) do
    'include ::prosody'
  end
  let(:facts) do
    {
      osfamily: 'SomeOS'
    }
  end
  let(:title) { 'mockvirtualhost' }

  before :each do
    @path_avail = "/etc/prosody/conf.avail/#{title}.cfg.lua"
    @path_link = "/etc/prosody/conf.d/#{title}.cfg.lua"
  end

  context 'with no parameters' do
    it {
      should contain_file(@path_avail).with(
        ensure: 'present'
      )
    }

    it {
      should contain_file(@path_link).with(
        ensure: 'link',
        target: @path_avail,
        require: "File[#{@path_avail}]"
      )
    }
  end

  context 'with ssl_key but no ssl_cert' do
    let(:params) { { ssl_key: 'bananas' } }
    it {
      expect do
        should contain_class('prosody')
      end.to raise_error(Puppet::Error)
    }
  end

  context 'with ssl_cert but no ssl_key' do
    let(:params) { { ssl_cert: 'bananas' } }
    it {
      expect do
        should contain_class('prosody')
      end.to raise_error(Puppet::Error)
    }
  end

  context 'with ssl keys and certs' do
    let(:ssl_key) { '/etc/prosody/certs/rspec-puppet.com.key' }
    let(:ssl_cert) { '/etc/prosody/certs/rspec-puppet.com.crt' }
    let(:params) { { ssl_key: ssl_key, ssl_cert: ssl_cert } }

    before :each do
      @ssl_key = ssl_key
      @ssl_cert = ssl_cert
    end

    it {
      # This require statment is bananas
      should contain_file(@path_avail).with(
        ensure: 'present',
        require: ['File[/etc/prosody/certs/mockvirtualhost.key]', 'File[/etc/prosody/certs/mockvirtualhost.crt]', 'Class[Prosody::Package]']
      )

      should contain_file('/etc/prosody/certs/mockvirtualhost.key').with_source(@ssl_key)
      should contain_file('/etc/prosody/certs/mockvirtualhost.crt').with_source(@ssl_cert)
    }
  end

  context 'ensure => absent' do
    let(:params) { { ensure: 'absent' } }
    it {
      @ensure = 'absent'
      should contain_file(@path_avail).with(
        ensure: @ensure
      )
    }

    it {
      should contain_file(@path_link).with_ensure('absent')
    }
  end

  context 'with custom options' do
    let(:params) { { custom_options: { 'foo' => 'bar', 'baz' => 'quux' } } }
    it {
      should contain_file(@path_avail) \
        .with_content(/^foo = "bar"$/, /^baz = "quux"$/)
    }
  end

  context 'with deeply nested custom options' do
    let(:params) { { custom_options: { 'foo' => { 'fnord' => '23', 'xyzzy' => '42' }, 'baz' => 'quux' } } }
    it {
      should contain_file(@path_avail) \
        .with_content(/^foo = {\n  fnord = "23";\n  xyzzy = "42";\n}$/, /^baz = "quux"$/)
    }
  end
end
