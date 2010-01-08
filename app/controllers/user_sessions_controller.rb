class UserSessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    sign_out_keeping_session!

    respond_to do |format|
      if user = User.authenticate(params[:email], params[:password])
        self.current_user = user
        flash[:notice] = 'You were successfully logged in.'
        format.html { redirect_to root_path }
      else
        flash[:error] = "Username or e-mail and/or password didn't match. Please try again."
        format.html { redirect_to login_path }
      end
    end
  end

  def destroy
    sign_out_killing_session!

    respond_to do |format|
      flash[:notice] = 'You were successfully logged out.'
      format.html { redirect_to root_path }
    end
  end
end
