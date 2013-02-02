class Gif < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User'

  mount_uploader :file, GifUploader
end
