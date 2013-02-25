module Dropbox
  class Uploader
    def self.upload_to_site(user_id, path)
      new(user_id, path).upload_to_site
    end

    def initialize(user_id, path)
      @user      = User.find(user_id)
      @path      = path
      @account   = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def upload_to_site
      image_data   = @account.image_data_for_path(@path)

      if image_data
        existing_image = Image.find_by_unique_hash image_data[:unique_hash]

        if existing_image.blank?
          # Sometimes a use has duplicate wallpapers which download in quick
          # succession. This causes a race condition and we end up trying to create
          # another wallpaper. We catch this exception here and do nothing (the
          # wallpaper is already on desktoppr).
          begin
            Image.new(image_data).tap do |image|
              image.uploader = @user
              image.save!
            end
          rescue ActiveRecord::RecordNotUnique
          end
        end
      end
    end
  end
end
