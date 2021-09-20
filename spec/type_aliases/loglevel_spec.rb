# frozen_string_literal: true

require 'spec_helper'

describe 'Prosody::Loglevel' do
  describe 'valid modes' do
    %w[
      debug
      info
      warn
      error
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'invalid modes' do
    context 'with garbage inputs' do
      [
        true,
        false,
        :keyword,
        nil,
        [nil],
        [nil, nil],
        { 'foo' => 'bar' },
        {},
        '',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
