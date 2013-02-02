class GifsController < ApplicationController
  def download
    if user_signed_in?
      Dropbox::Downloader.download_to_users_dropbox current_user.id, params[:id]
    end
  end
end
