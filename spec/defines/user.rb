require 'spec_helper'
require 'erb'

describe 'prosody::user' do
  let(:pre_condition) do
    'include ::prosody'
  end

  on_supported_os.each do |os, os_facts|
    context "on os #{os}" do
      let(:facts) do
        os_facts
      end

      context 'with simple parameters' do
        let(:params) { { name: 'bob', pass: 'pass123' } }

        it {
          is_expected.to contain_file('/var/lib/prosodoy/localhost/accounts/bob.dat').with(
            content: '
return {
  [\"password\"] = \"pass123\";
};',
            ensure: 'present',
            recurse: false,
            purge: false
          )
        }
      end

      context 'with complex domain' do
        let(:params) { { name: 'bob', pass: 'pass123', host: 'foo-bar.com' } }

        it {
          is_expected.to contain_file('/var/lib/prosodoy/foo%2dbar%2ecom/accounts/bob.dat').with(
            content: '
return {
  [\"password\"] = \"pass123\";
};',
            ensure: 'present'
          )
        }
      end

      context 'with complex username' do
        let(:params) { { name: 'bob.bar-foo', pass: 'pass123' } }

        it {
          is_expected.to contain_file('/var/lib/prosodoy/localhost/accounts/bob%2ebar%2dfoo.dat').with(
            content: '
return {
  [\"password\"] = \"pass123\";
};',
            ensure: 'present'
          )
        }
      end

      context 'with purging enabled' do
        let(:params) { { name: 'bob', pass: 'pass123', purge: true } }

        it {
          is_expected.to contain_file('/var/lib/prosodoy/foo%2dbar%2ecom/accounts/bob.dat').with(
            ensure: 'present'
          )
        }

        it {
          is_expected.to contain_file('/var/lib/prosodoy/foo%2dbar%2ecom/accounts').with(
            ensure: 'present',
            purge: true,
            recurse: true
          )
        }
      end
    end
  end
end
