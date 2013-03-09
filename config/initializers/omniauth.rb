require 'omniauth'

OmniAuth.config.logger = Rails.logger

dropbox_key = ENV['DROPBOX_KEY']
raise "Missing env variable DROPBOX_KEY" unless dropbox_key.present?

dropbox_secret = ENV['DROPBOX_SECRET']
raise "Missing env variable DROPBOX_SECRET" unless dropbox_secret.present?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, dropbox_key, dropbox_secret
end
