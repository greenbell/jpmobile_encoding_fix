# encoding: utf-8
require 'spec_helper'

describe String do
  describe '#toutf8_if_not' do
    context 'when the string is marked as UTF-8' do
      subject{ "\u{1F384}" }

      it "returns itself" do
        expect(subject.toutf8_if_not).to eq "\u{1F384}"
      end
    end

    context 'when the string is not marked as UTF-8' do
      subject{ "\u{1F384}".force_encoding('ASCII-8BIT') }

      it "returns UTF-8-converted string by guessing source encoding" do
        expect(subject.toutf8_if_not).to eq "\uE05E"
      end
    end
  end
end
