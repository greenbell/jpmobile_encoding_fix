require 'spec_helper'
require 'mail'
require 'jpmobile/mail'

describe Mail do
  subject{ Mail.new(File.read("#{File.dirname(__FILE__)}/../fixtures/docomo-jis.eml")) }

  it 'decodes received e-mail successfully' do
    expect(subject.subject).to eq 'テスト'
    expect(subject.from).to eq ["jpmobile.anonymous@docomo.ne.jp"]
    expect(subject.to).to eq ["info@jpmobile-rails.org"]
    expect(subject.body.to_s).to eq "テスト本文\n\n"
  end

  context 'with rfc-incompatible mail address' do
    # affects only mail < 2.5, patch is not needef for 2.5
    subject{ Mail.new(File.read("#{File.dirname(__FILE__)}/../fixtures/rfc_incompatible_address.eml")) }

    it "decodes from address properly" do
      expect(subject.mobile).to be_a_kind_of Jpmobile::Mobile::Docomo
      expect(subject.from).to eq ["jpmobile..@docomo.ne.jp", "info+to@jp.mobile"]
    end
  end

  context 'with mutiline B encoded subject' do
    subject{ Mail.new(File.read("#{File.dirname(__FILE__)}/../fixtures/multiline_subject.eml")) }

    it "decodes subject properly" do
      expect(subject.subject).to eq '7/7(月)たなばた☆'
    end
  end
end
