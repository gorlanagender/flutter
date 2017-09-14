class UserMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    UserMailer.sent_mail(user: User.first)
  end
end