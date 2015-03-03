OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "ev8b7RxNJi3aI48yEzIJ46cpy", "ulnekrRSnpDqT3mLJZpAWHJbnXnJGMMVO5tMaNCYE1ZaBO6rfS"
  provider :yahoo, "dj0yJmk9MXpXTVdJQ3RJS09GJmQ9WVdrOWFEWlBlbmxoTXpBbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD03NA--", "a9fe09bc5b43642d9d9e425a57947025d820bbc4"
  provider :facebook, '449175338566765', 'fc5cf452a26d931528b4394ef3c7e953',
           scope: 'email,user_birthday,read_stream', display: 'popup'
  provider :google_oauth2, '927139304986-e0jefhtuhejh57e6j0v2ct50l4dod52h.apps.googleusercontent.com', '9bKrV4dXvgWmLhUGNCArEpo5',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},provider_ignores_state: true }
end
