require 'spec_helper'

describe 'prosody::package' do
  context 'on every platform' do
    it {
      should contain_package('prosody').with(
        :ensure  => 'present',
      )
    }
  end
end
