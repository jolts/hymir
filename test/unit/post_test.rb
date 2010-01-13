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

    should 'not be published by default' do
      assert_equal false, @post.published
    end

    should 'not have published_at set' do
      assert_nil @post.published_at
    end

    should 'set published_at when published' do
      @post.published = true
      @post.save!
      assert @post.published_at
    end

    should 'create a slug' do
      assert_equal 'foo-bar-baz', @post.slug
    end

    should 'store tags in an array' do
      assert_equal ['foo', 'bar', 'baz'], @post.tags
    end

    should 'have an empty embedded document for comments' do
      assert_equal [], @post.comments
    end

    should 'store comments' do
      comment = Comment.new
      @post.comments << comment
      assert_equal [comment], @post.comments
    end

    should 'save valid comments' do
      comment = Comment.new(:name => 'John Doe', :email => 'john@doe.com', :body => 'Hello')
      @post.comments << comment
      assert_equal true, @post.valid?
    end

    should 'not save invalid comments' do
      comment = Comment.new
      @post.comments << comment
      assert_equal false, @post.valid?
    end

    should 'be able to delete specific comments' do
      comment = Comment.new
      @post.comments << comment
      @post.comments.delete_if {|c| c.id == comment.id}
      assert_equal [], @post.comments
    end
  end
end
