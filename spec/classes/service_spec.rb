require 'spec_helper'

describe 'prosody::service' do
  it {
    should contain_service('prosody').with(
      :ensure  => 'running',
      :require => 'Class[Prosody::Package]')
  }
end
