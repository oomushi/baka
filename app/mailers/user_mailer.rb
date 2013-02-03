class UserMailer < ActionMailer::Base
  default :from => "admin@baka.macrobug.uchi.invalid"
  def email_confirmation user
    @user=user
    mail(:to => user.email, :subject => t(:confirm_email) )
  end
end
