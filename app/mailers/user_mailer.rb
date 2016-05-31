class UserMailer < ApplicationMailer
  default :from => "brvast <postmaster@sandbox6ef0b2af45344d7b968b59d4e0b91c6c.mailgun.org>"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_comment(user)
        @user = user
        mail(:to => user.email, :subject => "New CommentPro")
  end
end
