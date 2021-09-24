require 'spec_helper'
require 'erb'

describe 'prosody::virtualhost' do
  let(:pre_condition) do
    'include ::prosody'
  end

  on_supported_os.each do |os, os_facts|
    context "on os #{os}" do
      let(:facts) do
        os_facts
      end

      let(:title) { 'mockvirtualhost' }

      let(:path_avail) { "#{prosody::config_directory}/conf.avail/#{title}.cfg.lua" }
      let(:path_link) { "#{prosody::config_directory}/conf.d/#{title}.cfg.lua" }

      context 'with no parameters' do
        it {
          is_expected.to contain_file(path_avail).with(
            ensure: 'present'
          )
        }

        it {
          is_expected.to contain_file(path_link).with(
            ensure: 'link',
            target: path_avail,
            require: "File[#{path_avail}]"
          )
        }
      end

      context 'without ssl_key nor ssl_cert' do
        it { is_expected.not_to contain_file(path_avail).with(content: %r[^  ssl = {$]) }
      end

      context 'with ssl_key but no ssl_cert' do
        let(:params) { { ssl_key: "#{prosody::config_directory}/certs/rspec-puppet.com.key" } }

        it { is_expected.to compile.and_raise_error(%r{The prosody::virtualhost type needs both ssl_key \*and\* ssl_cert set}) }
      end

      context 'with ssl_cert but no ssl_key' do
        let(:params) { { ssl_cert: "#{prosody::config_directory}/certs/rspec-puppet.com.crt" } }

        it { is_expected.to compile.and_raise_error(%r{The prosody::virtualhost type needs both ssl_key \*and\* ssl_cert set}) }
      end

      context 'with ssl keys and certs' do
        let(:ssl_key) { "#{prosody::config_directory}/certs/rspec-puppet.com.key" }
        let(:ssl_cert) { "#{prosody::config_directory}/certs/rspec-puppet.com.crt" }
        let(:params) { { ssl_key: ssl_key, ssl_cert: ssl_cert } }

        it {
          # This require statment is bananas
          is_expected.to contain_file(path_avail).with(
            ensure: 'present',
            require: ["File[#{prosody::config_directory}/certs/mockvirtualhost.key]", "File[#{prosody::config_directory}/certs/mockvirtualhost.crt]", 'Class[Prosody::Package]']
          )

          is_expected.to contain_file("#{prosody::config_directory}/certs/mockvirtualhost.key").with_source(ssl_key)
          is_expected.to contain_file("#{prosody::config_directory}/certs/mockvirtualhost.crt").with_source(ssl_cert)
        }
      end

      context 'ensure => absent' do
        let(:params) { { ensure: 'absent' } }

        it {
          is_expected.to contain_file(path_avail).with_ensure('absent')
        }

        it {
          is_expected.to contain_file(path_link).with_ensure('absent')
        }
      end

      context 'with custom options' do
        let(:params) { { custom_options: { 'foo' => 'bar', 'baz' => 'quux' } } }

        it {
          is_expected.to contain_file(path_avail). \
            with_content(%r{^foo = "bar"$}, %r{^baz = "quux"$})
        }
      end

      context 'with deeply nested custom options' do
        let(:params) { { custom_options: { 'foo' => { 'fnord' => '23', 'xyzzy' => '42' }, 'bar' => %w[cool elements], 'baz' => 'quux' } } }

        it {
          is_expected.to contain_file(path_avail). \
            with_content(%r{^foo = {\n  fnord = "23";\n  xyzzy = "42";\n}$}, %r{^baz = "quux"$}, %r{^bar = [ "cool"; "elements" ]$})
        }
      end

      context 'with disco items' do
        let(:params) { { disco_items: %w[foo bar] } }

        it {
          is_expected.to contain_file(path_avail). \
            with_content(%r{^disco_items = \{\n  \{ \"foo\" \}\;\n  \{ \"bar\" \}\;\n\}})
        }
      end
    end
  end
end
