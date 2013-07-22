class User < ActiveRecord::Base
  has_many :images, class_name: "Image",
                          foreign_key: "uploader_id"

  validates :provider, :uid, :name, :email, :oauth_token, :oauth_secret, :presence => true
end
