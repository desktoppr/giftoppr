class Gif < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'User'
end
