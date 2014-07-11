# coding: utf-8

require 'jpmobile/mail' # 先に読み込まないとmonkey patchが上書きされてしまう

module JpmobileEncodingFix
  module Mail
    ##
    # Subjectに改行を挟んでB encodingが出現する際に正しくdecodeされない問題の対策
    #
    if ::Mail::Ruby19.b_value_decode("=?iso-2022-jp?B?GyRCJDMbKEI=GyRCJHMkSyRBJG8bKEI=?=") == 'こんにちわ'
      raise 'b_value_decode multiline Base64 fix is already applied'
    end
    module Ruby19
      def self.extended(base)
        base.class_eval do
          class << self
            alias_method_chain :decode_base64, :multiline_fix
          end
        end
      end

      def decode_base64_with_multiline_fix(str)
        str.scan(/[^=]+=*/).map{|part| part.unpack( 'm' ).first }.join
      end
    end
  end
end

Mail::Ruby19.send(:extend, JpmobileEncodingFix::Mail::Ruby19)
