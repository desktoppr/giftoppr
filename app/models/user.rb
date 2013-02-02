class User < ActiveRecord::Base
  validates :name, :provider, :uid, :presence => true
end
