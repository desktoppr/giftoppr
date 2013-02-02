module Dropbox
  class Copier
    def self.copy_to_users_dropbox(user_id, gif_id)
      new(user_id, gif_id).copy_to_users_dropbox
    end

    def initialize(user_id, gif_id)
      @user    = User.find(user_id)
      @gif     = Gif.find(gif_id)
      @account = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def copy_to_users_dropbox
      path = File.basename(@gif.file.path)
      @account.put_file(path, StringIO.new(@gif.file.read))
    end
  end
end
