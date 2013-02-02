module Dropbox
  class Sync
    def initialize(user_id)
      @user = User.find(user_id)
      @account = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def sync_from_cursor
      save_cursor sync_and_return_cursor(@user.change_cursor)
    end

    def fresh_sync
      save_cursor sync_and_return_cursor(nil)
    end

    private

    def save_cursor(cursor)
      @user.update_attribute :change_cursor, cursor if cursor
    end

    def sync_and_return_cursor(cursor)
      files = @account.changed_files_from_cursor(cursor, /.gif/)

      if files
        files[:entries].each do |file|
          path = file[0]
          meta_data = file[1]

          # If metadata is blank then it is an 'remove'
          Dropbox::Downloader.new(@user.id, path, meta_data).download if meta_data.present?
        end

        files[:cursor]
      else
        false
      end
    end
  end
end
