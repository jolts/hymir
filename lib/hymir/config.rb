module Hymir
  module Config
    extend self

    def [](key)
      unless @config
        raw_config = File.read(File.join(RAILS_ROOT, 'config/hymir.yml'))
        @config = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
      end
      @config[key]
    end
    alias_method :get, :[]
    
    def []=(key, value)
      @config[key.to_sym] = value
    end
    alias_method :set, :[]=
  end
end
