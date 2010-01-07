require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'A post' do
    setup do
      @post = Post.new
    end

    should 'not save without the required fields' do
      assert_equal false, @post.valid?
    end
  end

  context 'A post with data' do
    setup do
      @post = Factory(:post)
    end

    should 'have a user_id' do
      assert @post.user_id
    end

    should 'create a slug' do
      assert_equal 'foo-bar-baz', @post.slug
    end

    should 'store tags in an array and string' do
      assert_equal ['foo', 'bar', 'baz'], @post.tags
      assert_equal 'foo; bar; baz', @post.named_tags
    end
  end
end
