class UserNotifier < ActionMailer::Base
  def forgot_password(user)
    recipients user.email
    from       Hymir::Config[:email]
    subject    '[hymir] Reset Password'
    sent_on    Time.now
    body       :url => "#{Hymir::Config[:domain]}reset_password/#{user.reset_password_code}", :user => user
  end
end
