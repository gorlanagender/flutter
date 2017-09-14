class UserMailer < ApplicationMailer
  def sent_mail(user:)
    @user = user
    mail(to: @user.email, subject: 'Notification Email')
  end
end