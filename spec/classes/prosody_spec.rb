require 'spec_helper'

describe 'prosody' do
  let(:facts) do
    { osfamily: 'SomeOS' }
  end
  context 'on every platform' do
    it { should contain_class 'prosody::package' }
    it { should contain_class 'prosody::config' }
    it { should contain_class 'prosody::service' }

    it { should contain_package('prosody').with(ensure: 'present') }
  end

  context 'with daemonize => true' do
    let(:params) { { daemonize: true } }
    it {
      should contain_service('prosody').with(
        ensure: 'running'
      )
    }
  end

  context 'with daemonize => false' do
    let(:params) { { daemonize: false } }
    it {
      should_not contain_service('prosody').with(
        ensure: 'running'
      )
    }
  end

  context 'with custom options' do
    let(:params) { { custom_options: { 'foo' => 'bar', 'baz' => 'quux' } } }
    it {
      should contain_file('/etc/prosody/prosody.cfg.lua') \
        .with_content(/^foo = "bar"$/, /^baz = "quux"$/)
    }
  end

  context 'with deeply nested custom options' do
    let(:params) { { custom_options: { 'foo' => { 'fnord' => '23', 'xyzzy' => '42' }, 'baz' => 'quux' } } }
    it {
      should contain_file('/etc/prosody/prosody.cfg.lua') \
        .with_content(/^foo = {\n  fnord = "23";\n  xyzzy = "42";\n}$/, /^baz = "quux"$/)
    }
  end
end
