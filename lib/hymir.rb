module Hymir
  module VERSION
    MAJOR = '0'
    MINOR = '0'
    TINY  = 'alpha'

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  def self.[](key)
    unless @config
      raw_config = File.read(File.join(RAILS_ROOT, 'config/hymir.yml'))
      @config = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
    end
    @config[key]
  end
  
  def self.[]=(key, value)
    @config[key.to_sym] = value
  end
end
