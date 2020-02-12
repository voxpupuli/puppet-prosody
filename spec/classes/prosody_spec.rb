require 'spec_helper'

describe 'prosody' do
  let(:facts) do
    { os: { family: 'SomeOS', name: 'SomeOS' } }
  end

  context 'on every platform' do
    it { is_expected.to contain_class 'prosody::package' }
    it { is_expected.to contain_class 'prosody::config' }
    it { is_expected.to contain_class 'prosody::service' }

    it { is_expected.to contain_package('prosody').with(ensure: 'present') }
  end

  context 'with daemonize => true' do
    let(:params) { { daemonize: true } }

    it {
      is_expected.to contain_service('prosody').with(
        ensure: 'running'
      )
    }
  end

  context 'with daemonize => false' do
    let(:params) { { daemonize: false } }

    it {
      is_expected.not_to contain_service('prosody').with(
        ensure: 'running'
      )
    }
  end

  context 'with custom options' do
    let(:params) { { custom_options: { 'foo' => 'bar', 'baz' => 'quux' } } }

    it {
      is_expected.to contain_file('/etc/prosody/prosody.cfg.lua'). \
        with_content(%r{^foo = "bar"$}, %r{^baz = "quux"$})
    }
  end

  context 'with deeply nested custom options' do
    let(:params) { { custom_options: { 'foo' => { 'fnord' => '23', 'xyzzy' => '42' }, 'bar' => %w[cool elements], 'baz' => 'quux' } } }

    it {
      is_expected.to contain_file('/etc/prosody/prosody.cfg.lua'). \
        with_content(%r{^foo = {\n  fnord = "23";\n  xyzzy = "42";\n}$}, %r{^baz = "quux"$}, %r{^bar = [ "cool"; "elements" ]$})
    }
  end
end
