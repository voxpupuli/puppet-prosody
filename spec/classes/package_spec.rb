require 'spec_helper'

describe 'prosody::package' do
  context 'on Ubuntu' do
    let(:facts) do
      {
        :operatingsystem => 'Ubuntu'
      }
    end

    it { should contain_package('prosody') }
  end
end
