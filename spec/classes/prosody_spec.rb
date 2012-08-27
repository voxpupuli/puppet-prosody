require 'spec_helper'

describe 'prosody' do
  let(:facts) {
    {
      :operatingsystem => 'Ubuntu'
    }
  }

  it { should include_class 'prosody::package' }
  it { should include_class 'prosody::service' }
end
