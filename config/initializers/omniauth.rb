OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, Dropbox.app_key, Dropbox.app_secret
end
