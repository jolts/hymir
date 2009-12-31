class UserSessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if user = User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        @current_user = user
        flash[:notice] = 'You were successfully logged in.'
        format.html { redirect_back_or_default(root_url) }
      else
        flash[:error] = 'Login failed'
        format.html { render :action => 'new' }
      end
    end
  end

  def destroy
    sign_out_keeping_session!

    respond_to do |format|
      flash[:notice] = 'You were successfully logged out.'
      format.html { redirect_back_or_default(root_url) }
    end
  end
end
