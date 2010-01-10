require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'Creating a new user as a guest' do
    # These actions are unavailable for non-admins
    setup do
      get :new
    end

    should_redirect_to(Hymir::Config[:title]) { root_path }

    should 'have "Access denied" in flash[:error]' do
      assert flash[:error].include?('Access denied')
    end
  end

  context 'Listing users as a guest' do
    setup do
      get :index
    end

    should_redirect_to(Hymir::Config[:title]) { root_path }

    should 'have "Access denied" in flash[:error]' do
      assert flash[:error].include?('Access denied')
    end
  end
end
