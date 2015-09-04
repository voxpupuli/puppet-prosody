require 'spec_helper'

describe 'prosody::service' do
  context 'with daemonize => true' do
    let(:params) { {:daemonize => true} }
    it {
      should contain_service('prosody').with(
        :ensure  => 'running',
      )
    }
  end
  context 'with daemonize => false' do
    let(:params) { {:daemonize => false} }
    it {
      should_not contain_service('prosody').with(
        :ensure  => 'running',
      )
    }
  end
end
