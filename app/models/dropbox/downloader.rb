module Dropbox
  class Downloader
    def initialize(user_id, path, meta_data)
      @user      = User.find(user_id)
      @path      = path
      @meta_data = meta_data
      @account   = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def download
      p @account.image_data_for_path(@path)
    end
  end
end
