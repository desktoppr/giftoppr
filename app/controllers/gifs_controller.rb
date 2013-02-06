class GifsController < ApplicationController
  respond_to :json

  def index
    @gifs = Gif.latest.page(params[:page]).per(20)

    respond_with @gifs
  end

  def download
    if user_signed_in?
      Dropbox::Copier.copy_to_users_dropbox current_user.id, params[:id]
    end

    render :nothing => true
  end
end
