module Dropbox
  class Copier
    def self.copy_to_users_dropbox(user_id, image_id)
      new(user_id, image_id).copy_to_users_dropbox
    end

    def initialize(user_id, image_id)
      @user    = User.find(user_id)
      @image   = Image.find(image_id)
      @account = Account.new(@user.oauth_token, @user.oauth_secret)
    end

    def copy_to_users_dropbox
      path = File.basename(@image.file.path)
      @account.put_file(path, StringIO.new(@image.file.read))
    end
  end
end
