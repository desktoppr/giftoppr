class Gif < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User'

  mount_uploader :file, GifUploader

  scope :latest, :order => 'created_at desc'
end
