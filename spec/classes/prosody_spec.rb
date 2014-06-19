require 'spec_helper'

describe 'prosody' do
  context 'on every platform' do
    it { should contain_class 'prosody::package' }
    it { should contain_class 'prosody::config' }
    it { should contain_class 'prosody::service' }
  end
end
