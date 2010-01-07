require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'A post' do
    setup do
      @post = Post.new
    end

    should 'not save without the required fields' do
      assert !@post.save
    end

    should 'create a slug' do
      @post.title = 'foo bar baz'
      @post.body = 'bar'
      @post.save!
      assert_equal 'foo-bar-baz', @post.slug
    end
  end
end
