class Dropbox
  # This class allows us to create a wallpaper from a StringIO
  class FilelessIO < StringIO
    attr_accessor :original_filename
  end

  def self.app_key
    ENV['DROPBOX_KEY']
  end

  def self.app_secret
    ENV['DROPBOX_SECRET']
  end

  attr_reader :client

  delegate :put_file, :file_delete, :add_copy_ref, :create_copy_ref, :to => :client

  def initialize(oauth_token, oauth_secret, file_regex)
    session = DropboxSession.new(app_key, app_secret)
    session.set_access_token(oauth_token, oauth_secret)

    @client = DropboxClient.new(session, :app_folder)
    @file_regex = file_regex
  end

  def updated_image_info(cursor = nil)
    results        = client.delta(cursor)
    cursor         = results['cursor']
    has_more       = results['has_more']
    changed_images = results['entries'].select { |change| change.first.match(@file_regex) }

    { :cursor => cursor,
      :has_more => has_more,
      :changed_images => changed_images }
  end

  def image_data(path)
    image_string           = client.get_file(path)
    data                   = FilelessIO.new(image_string)
    unique_hash            = Digest::SHA1.hexdigest(image_string)
    data.original_filename = Pathname.new(path).basename.to_s
    dimensions             = FastImage.new(data).size

    { :width => dimensions.try(:first),
      :height => dimensions.try(:second),
      :unique_hash => unique_hash,
      :file => data,
      :bytes => data.size }
  end
end
