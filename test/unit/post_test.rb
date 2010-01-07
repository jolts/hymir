require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'A post' do
    setup do
      @post = Post.new
    end

    should 'not save without the required fields' do
      assert !@post.save
    end
  end

  context 'A post with data' do
    setup do
      @post = Factory(:post)
    end

    should 'create a slug' do
      assert_equal 'foo-bar-baz', @post.slug
    end
  end
end
