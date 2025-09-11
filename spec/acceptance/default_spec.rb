# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'prosody' do
  it_behaves_like 'an idempotent resource' do
    let(:manifest) do
      <<-PUPPET
      include prosody
      PUPPET
    end

    it 'works idempotently with no errors' do
      apply_manifest(manifest, catch_failures: true)
      apply_manifest(manifest, catch_changes: true)
    end

    describe service('prosody.service') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end

    it { expect(package('prosody')).to be_installed }

    describe command('prosodyctl status') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{^Prosody is running} }
    end
  end
end
