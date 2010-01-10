require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'Visiting new as a guest' do
    # These actions are unavailable for non-admins
    setup do
      get :new
    end

    should_redirect_to(Hymir::Config[:title]) { root_path }

    should 'have "Access denied" in flash[:error]' do
      assert flash[:error].include?('Access denied')
    end
  end

  context 'Visiting index as a guest' do
    setup do
      get :index
    end

    should_redirect_to(Hymir::Config[:title]) { root_path }

    should 'have "Access denied" in flash[:error]' do
      assert flash[:error].include?('Access denied')
    end
  end

  context 'Visiting new as an admin' do
    setup do
      session[:user_id] = Factory(:user)._id
      get :new
    end

    should_respond_with :success
  end

  context 'Creating a new user as an admin' do
    setup do
      session[:user_id] = Factory(:user)._id
      post :create, :user => Factory.attributes_for(:user)
    end

    should_change 'User.count', :by => 1
  end

  context 'Visiting index as an admin' do
    setup do
      session[:user_id] = Factory(:user)._id
      get :index
    end

    should_respond_with :success
  end
end
