module Hymir
  module Gravatar
    def gravatar(size = 50, default = nil)
      url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size}"
      url += "&d=#{default}" if default
      url
    end
  end
end
