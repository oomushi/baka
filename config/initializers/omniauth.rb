OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1094586320801-nvg6i4lnlikepj2tl5unqomc1qtm6m5i.apps.googleusercontent.com', 'U4M5H3HiQl1Fr7O8_024_Idm', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
