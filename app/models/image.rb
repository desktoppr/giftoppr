class Image < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User'

  mount_uploader :file, ImageUploader

  scope :latest, :order => 'created_at desc'
end
