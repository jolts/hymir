class UserSessionsController < ApplicationController
  def new
  end

  def create
    sign_out_keeping_session!

    if user = User.authenticate(params[:email], params[:password])
      self.current_user = user
      flash[:notice] = t('flash.notice.user_sessions.new')
      redirect_back_or_default root_path
    else
      flash[:error] = t('flash.error.user_sessions.new')
      redirect_back_or_default login_path
    end
  end

  def forgot_password
    if user = User.find_by_email(params[:email])
      user.set_password_code!
      Mailer.send_later :deliver_password_reset_notification, user
      flash[:notice] = t('flash.notice.user_sessions.forgot_password', :email => user.email)
      redirect_to root_path
    else
      flash[:error] = t('flash.error.user_sessions.forgot_password')
      redirect_to login_path
    end
  end

  def destroy
    sign_out_killing_session!
    flash[:notice] = t('flash.notice.user_sessions.destroy')
    redirect_to root_path
  end
end
