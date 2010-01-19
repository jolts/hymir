module Hymir
  module Version
    MAJOR = '1'
    MINOR = '0'
    TINY  = 'pre'

    def self.to_s
      [MAJOR, MINOR, TINY].join('.').freeze
    end
  end
end
