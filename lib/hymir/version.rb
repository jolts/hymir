module Hymir
  module Version
    extend self

    MAJOR = '1'
    MINOR = '0'
    TINY  = 'beta3'

    def to_s
      [MAJOR, MINOR, TINY].join('.').freeze
    end
    alias_method :to_str, :to_s
  end
end
