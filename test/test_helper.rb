ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  def teardown
    MongoMapper.database.collections.each do |coll|
      coll.remove
    end
  end

  def inherited(base)
    base.define_method teardown do
      super
    end
  end
end
