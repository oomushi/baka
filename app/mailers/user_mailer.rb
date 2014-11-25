class UserMailer < ActionMailer::Base
  default :from => "baka@macrobug.dev.invalid"
  def email_confirmation user
    @user=user
    mail(:to => user.email, :subject => t(:confirm_email) )
  end
  def forgotten_password user
    @user=user
    mail(:to => user.email, :subject => t(:forgotten_password) )
  end
end
