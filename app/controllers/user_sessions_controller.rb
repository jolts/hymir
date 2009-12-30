class UserSessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      @current_user = user
      flash[:notice] = 'You were successfully logged in.'
      redirect_back_or_default(root_url)
    else
      flash[:error] = 'Login failed'
      render :action => 'new'
    end
  end

  def destroy
    sign_out_keeping_session!
    flash[:notice] = 'You were successfully logged out.'
    redirect_back_or_default(root_url)
  end
end
