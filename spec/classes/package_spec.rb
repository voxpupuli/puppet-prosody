require 'spec_helper'

describe 'prosody::package' do
  context 'on Ubuntu' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu'
      }
    end

    it {
      should contain_package('prosody').with(
        :ensure  => 'present',
        :require => 'Package[openssl]'
      )
    }

    it {
      should contain_package('openssl').with(
        :ensure => 'present'
      )
    }
  end

  context 'elsewhere' do
    let(:facts) do
      {
        :operatingsystem => 'CentOS'
      }
    end

    it {
      expect {
        should contain_package('prosody')
      }.to raise_error(Puppet::Error)
    }
  end
end
