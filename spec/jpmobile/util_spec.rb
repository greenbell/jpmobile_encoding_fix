# encoding: utf-8
require 'spec_helper'

describe Jpmobile::Util do
  context "in instance context" do
    include Jpmobile::Util
    it "U+00A5が0xFFE5に変換されること(円記号を全角に)" do
      utf8_to_sjis([0x00A5].pack("U")).should == sjis("\x81\x8F")
    end

    it "U+F001(Softbank絵文字)が使われていてもエラーにならないこと" do
      utf8_to_sjis([0xF001].pack("U")).should == sjis("")
    end
  end

  context "in module context" do
    it "U+00A5が0xFFE5に変換されること(円記号を全角に)" do
      Jpmobile::Util.utf8_to_sjis([0x00A5].pack("U")).should == Jpmobile::Util.sjis("\x81\x8F")
    end

    it "U+F001(Softbank絵文字)が使われていてもエラーにならないこと" do
      Jpmobile::Util.utf8_to_sjis([0xF001].pack("U")).should == Jpmobile::Util.sjis("")
    end
  end
end
