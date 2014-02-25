require 'jpmobile_encoding_fix/version'
require 'jpmobile'
require 'active_support/core_ext'

module JpmobileEncodingFix
  def self.included(base)
    base.alias_method_chain :utf8_to_sjis, :encoding_fix
    base.send :module_function, :utf8_to_sjis, :yen_sign_to_fullwidth_yen_sign
  end

  YEN_SIGN = [0x00a5].pack("U")
  FULLWIDTH_YEN_SIGN = [0xffe5].pack("U")

  def yen_sign_to_fullwidth_yen_sign(utf8_str)
    utf8_str.gsub(YEN_SIGN, FULLWIDTH_YEN_SIGN)
  end

  def utf8_to_sjis_with_encoding_fix(utf8_str)
    # 波ダッシュ対策
    utf8_str = wavedash_to_fullwidth_tilde(utf8_str)
    # オーバーライン対策(不可逆的)
    utf8_str = overline_to_fullwidth_macron(utf8_str)
    # ダッシュ対策（不可逆的）
    utf8_str = emdash_to_horizontal_bar(utf8_str)
    # マイナス対策（不可逆的）
    utf8_str = minus_sign_to_fullwidth_hyphen_minus(utf8_str)
    # 円マーク対策（不可逆）
    utf8_str = yen_sign_to_fullwidth_yen_sign(utf8_str)

    utf8_str.
      gsub(/(\r\n|\r|\n)/, "\r\n").
      encode(Jpmobile::Util::SJIS, :undef => :replace, :replace => '')
  end
end

Jpmobile::Util.module_eval do
  include JpmobileEncodingFix
end
