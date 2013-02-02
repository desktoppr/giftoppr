class User < ActiveRecord::Base
  has_many :gifs

  validates :provider, :uid, :name, :email, :oauth_token, :oauth_secret, :presence => true
end
