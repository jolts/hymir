ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  def setup
    Dir[File.join(Rails.root, 'app/models/**/*.rb')].each do |model_path|
      model_name = File.basename(model_path).gsub(/\.rb$/, '')
      return if model_name == 'ability' || model_name == 'comment'
      klass = model_name.classify.constantize
      klass.collection.remove
    end
  end
end
