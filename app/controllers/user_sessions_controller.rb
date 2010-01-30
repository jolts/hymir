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
        flash[:notice] = t('flash.notice.user_sessions.new')
        format.html { redirect_back_or_default root_path }
      else
        flash[:error] = t('flash.error.user_sessions.new')
        format.html { redirect_back_or_default login_path }
      end
    end
  end

  def forgot_password
    respond_to do |format|
      if user = User.find_by_email(params[:email])
        user.set_password_code!
        Mailer.deliver_password_reset_notification user
        flash[:notice] = t('flash.notice.user_sessions.forgot_password', :email => user.email)
        format.html { redirect_to root_path }
      else
        flash[:error] = t('flash.error.user_sessions.forgot_password')
        format.html { redirect_to login_path }
      end
    end
  end

  def destroy
    sign_out_killing_session!

    respond_to do |format|
      flash[:notice] = t('flash.notice.user_sessions.destroy')
      format.html { redirect_to root_path }
    end
  end
end
