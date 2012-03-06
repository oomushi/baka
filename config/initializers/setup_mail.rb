ActionMailer::Base.smtp_settings = {
  :address              => "smtp.libero.it",
  :port                 => 25,
# :user_name            => "baka",
# :password             => "",
# :authentication       => "plain",
  :enable_starttls_auto => true,
  :from                 => "Baka <admin@baka.heroku.com.invalid"
}
