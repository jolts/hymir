class Mailer < ActionMailer::Base
  def password_reset_notification(user)
    recipients user.email
    from       Hymir::Config[:email]
    subject    '[hymir] Reset Password'
    sent_on    Time.now
    body       :url => "#{Hymir::Config[:domain]}reset_password/#{user.reset_password_code}", :user => user
  end
end
