source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '3.2.13.rc1'
gem 'pg'

# Dropbox
gem 'omniauth-dropbox'
gem 'dropbox-sdk', :require => 'dropbox_sdk'

# Uploading assets to S3
gem 'fog'
gem 'asset_sync'

# Image processing
gem 'fastimage'
gem 'carrierwave'
gem 'mini_magick'

# Front end stuff
gem 'kaminari'

# Production
gem 'unicorn'
gem 'foreman'
gem 'bugsnag'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'font-awesome-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'colorize'
end
