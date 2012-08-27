require 'spec_helper'
require 'erb'

describe 'prosody::virtualhost' do
  let(:title) { 'mockvirtualhost' }
  let(:facts) {
    {
      :operatingsystem => 'Ubuntu'
    }
  }

  before :each do
    # This will be useful for rendering the template cleanly/easily
    @name = title
  end

  it { should include_class 'prosody' }

  def render_template
    path = File.expand_path(File.dirname(__FILE__) + "/../../templates/virtualhost.cfg.erb")
    ERB.new(File.read(path)).result(binding)
  end

  context 'with no parameters' do
    it {
      @ensure = 'present'
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :content => render_template
      )
    }
  end

  context 'ensure => absent' do
    let(:params) { { :ensure => 'absent' } }
    it {
      @ensure = 'absent'
      should contain_file("#{title}.cfg.lua").with(
        :ensure  => 'present',
        :content => render_template
      )
    }
  end
end
