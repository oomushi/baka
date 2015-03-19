OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id
  provider :facebook, Rails.application.config.omniauth_facebook_id, Rails.application.config.omniauth_facebook_pw,
           scope: 'email,user_birthday', display: 'popup'
  provider :google_oauth2, Rails.application.config.omniauth_google_id, Rails.application.config.omniauth_google_pw,
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},provider_ignores_state: true }
end
