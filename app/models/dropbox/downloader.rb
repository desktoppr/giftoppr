module Dropbox
  class Downloader
    def initialize(user_id, path, meta_data)
      @user      = User.find(user_id)
      @path      = path
      @meta_data = meta_data
      @account   = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def download
      image_data   = @account.image_data_for_path(@path)

      if image_data
        existing_gif = Gif.find_by_unique_hash image_data[:unique_hash]

        if existing_gif.blank?
          # Sometimes a use has duplicate wallpapers which download in quick
          # succession. This causes a race condition and we end up trying to create
          # another wallpaper. We catch this exception here and do nothing (the
          # wallpaper is already on desktoppr).
          begin
            Gif.new(image_data).tap do |gif|
              gif.uploader = @user
              gif.save!
            end
          rescue ActiveRecord::RecordNotUnique
          end
        end
      end
    end
  end
end
