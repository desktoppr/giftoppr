class GifUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  EXTENSIONS_WHITELIST = %w(gif)

  def store_dir
    "gifs/#{model.unique_hash}"
  end

  version :preview do
    process :quality_and_strip => 80

    def full_filename(*args)
      super.chomp(File.extname(super)) + '.jpg' # Force extension to be jpg
    end
  end

  def extension_white_list
    EXTENSIONS_WHITELIST
  end

  # This is here to fix an issue where AWS S3 does not like plus characters in
  # filenames
  def filename
    original_filename.try(:gsub, '+', '-')
  end

  private

  # Run all the commands in 1 manipulate block to limit the amount of IO
  # stuff that has to happen on a single upload
  def quality_and_strip(percentage)
    manipulate! do |img|
      img.format('jpg') # We want to enforce jpeg so we can use good compression.
      img.strip # Do not store EXIF data in the thumb to save space
      img.quality(percentage.to_s)
      img = yield(img) if block_given?
      img
    end
  end
end
