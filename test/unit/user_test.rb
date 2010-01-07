require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'A user' do
    setup do
      @user = User.new
    end

    should 'not save without the required fields' do
      assert !@user.save
    end

    should 'store email as lowercase' do
      @user.email = 'FOO@BAR.COM'
      assert_equal 'foo@bar.com', @user.email
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
