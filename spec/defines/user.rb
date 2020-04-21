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
            ensure: 'present'
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
    end
  end
end