class GifUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  EXTENSIONS_WHITELIST = %w(gif)

  version :preview do
    process :convert => :jpg
    process :quality => 80
    process :strip # Do not store EXIF data in the thumb to save space

    def full_filename(*args)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  def store_dir
    "gifs/#{model.unique_hash}"
  end

  def extension_white_list
    EXTENSIONS_WHITELIST
  end

  # This is here to fix an issue where AWS S3 does not like plus characters in
  # filenames
  def filename
    original_filename.try(:gsub, '+', '-')
  end
end
