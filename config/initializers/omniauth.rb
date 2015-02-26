OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
=begin
  provider :twitter, "API_KEY", "API_SECRET"
  provider :yahoo, "API_KEY", "API_SECRET"
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :scope => 'email,user_birthday,read_stream', :display => 'popup'
=end
  provider :google_oauth2, '1094586320801-nvg6i4lnlikepj2tl5unqomc1qtm6m5i.apps.googleusercontent.com', 'U4M5H3HiQl1Fr7O8_024_Idm',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},provider_ignores_state: true }
end
