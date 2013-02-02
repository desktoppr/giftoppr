class User < ActiveRecord::Base
  validates :provider, :uid, :name, :email, :oauth_token, :oauth_secret, :presence => true
end
