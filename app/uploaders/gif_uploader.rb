class GifUploader < CarrierWave::Uploader::Base
  EXTENSIONS_WHITELIST = %w(gif)

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
