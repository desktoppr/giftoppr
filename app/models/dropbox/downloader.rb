module Dropbox
  class Downloader
    def self.download_to_users_dropbox(user_id, gif_id)
      new(user_id, gif_id).download_to_users_dropbox
    end

    def initialize(user_id, gif_id)
      @user    = User.find(user_id)
      @gif     = Gif.find(gif_id)
      @account = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def download_to_users_dropbox
      raise @gif.inspect
    end
  end
end
