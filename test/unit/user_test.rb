require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'A user' do
    setup do
      @user = User.new
    end

    should 'not save without the required fields' do
      assert_equal false, @user.valid?
    end

    should 'store email as lowercase' do
      @user.email = 'FOO@BAR.COM'
      assert_equal 'foo@bar.com', @user.email
    end
  end

  context 'A user with data' do
    setup do
      @user = Factory(:user)
    end

    should 'have posts' do
      assert_equal [], @user.posts
    end

    should 'have specific role masks' do
      assert_equal 1, @user.roles_mask
      @user.roles = ['moderator']
      assert_equal 2, @user.roles_mask
      @user.roles = ['moderator', 'admin']
      assert_equal 3, @user.roles_mask
      @user.roles = ['author']
      assert_equal 4, @user.roles_mask
      @user.roles = ['author', 'admin']
      assert_equal 5, @user.roles_mask
      @user.roles = ['author', 'moderator']
      assert_equal 6, @user.roles_mask
      @user.roles = ['author', 'moderator', 'admin']
      assert_equal 7, @user.roles_mask
    end

    should 'encrypt its password' do
      password = BCrypt::Password.new(@user.crypted_password)
      assert_equal password, @user.password
    end
  end

  context 'Authentication' do
    setup do
      @user = Factory(:user)
    end

    should 'work with correct username/email and password' do
      assert_equal @user, User.authenticate(@user.username, 'abcdef')
      assert_equal @user, User.authenticate(@user.email, 'abcdef')
    end

    should 'not work with incorrect password' do
      assert_nil User.authenticate(@user.username, 'foo')
    end

    should 'not work with incorrect username or email' do
      assert_not_equal @user, User.authenticate('foo', 'abcdef')
      assert_not_equal @user, User.authenticate('foo@bar.com', 'abcdef')
    end
  end
end
