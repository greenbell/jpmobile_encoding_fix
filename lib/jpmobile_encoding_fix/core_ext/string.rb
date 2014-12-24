require 'kconv'

String.class_eval do
  def toutf8_if_not
    if encoding == Encoding::UTF_8
      self
    else
      toutf8
    end
  end
end
