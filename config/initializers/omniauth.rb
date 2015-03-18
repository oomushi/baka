OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :browser_id
  provider :facebook, '456421621175470', '1e0b2c916c5a648dd9e815034c018d8f',
           scope: 'email,user_birthday', display: 'popup'
=begin
  provider :facebook, '449175338566765', 'fc5cf452a26d931528b4394ef3c7e953',
           scope: 'email,user_birthday', display: 'popup'
=end
  provider :google_oauth2, '927139304986-e0jefhtuhejh57e6j0v2ct50l4dod52h.apps.googleusercontent.com', '9bKrV4dXvgWmLhUGNCArEpo5',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},provider_ignores_state: true }
end
