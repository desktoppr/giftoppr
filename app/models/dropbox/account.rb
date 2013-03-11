module Dropbox
  class Account
    delegate :put_file, :file_delete, :add_copy_ref, :create_copy_ref, :to => :client

    def initialize(token, secret)
      @token = token
      @secret = secret
    end

    def image_data_for_path(path)
      Dropbox::Image.new(client.get_file(path), path).to_hash
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
