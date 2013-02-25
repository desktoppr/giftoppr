class User < ActiveRecord::Base
  has_many :images

  validates :provider, :uid, :name, :email, :oauth_token, :oauth_secret, :presence => true
end
