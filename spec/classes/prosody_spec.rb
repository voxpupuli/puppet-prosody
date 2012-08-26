require 'spec_helper'

describe 'prosody' do
  it { should include_class 'prosody::package' }
  it { should include_class 'prosody::service' }
end
