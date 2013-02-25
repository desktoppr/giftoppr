module Dropbox
  class Account
    # This class allows us to create a wallpaper from a StringIO
    class FilelessIO < StringIO
      attr_accessor :original_filename
    end

    delegate :put_file, :file_delete, :add_copy_ref, :create_copy_ref, :to => :client

    def initialize(token, secret)
      @token = token
      @secret = secret
    end

    def image_data_for_path(path)
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
    rescue DropboxError => e
      # File has probably been deleted
    end

    def changed_files_from_cursor(cursor = nil, regex = nil)
      results        = client.delta(cursor)
      cursor         = results['cursor']
      has_more       = results['has_more']

      entries = results['entries']
      entries.select! { |change| change.first.match(regex) } if regex

      { :cursor => cursor, :has_more => has_more, :entries => entries }
    rescue DropboxError => e
      # FIXME: When updated_image_info fails we get this exception. Probably
      # means the user has deauthorized dropbox.  Might be a good idea here
      # to perform some action. Maybe if it keeps on happening we unlink
      # their dropbox?
      Rails.logger.warn "Dropbox Account failed to get delta changes with error: #{e.message}. Skipping"

      nil
    end

    private

    def client
      unless @client
        session = DropboxSession.new ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET']
        session.set_access_token @token, @secret

        @client = DropboxClient.new session, :app_folder
      end

      @client
    end
  end
end
