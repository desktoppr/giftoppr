Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET']
end
