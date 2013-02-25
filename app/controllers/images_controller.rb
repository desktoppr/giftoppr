class ImagesController < ApplicationController
  def show
    image = Image.order('random() asc').first

    redirect_to image.file.url
  end

  def download
    if user_signed_in?
      Dropbox::Copier.copy_to_users_dropbox current_user.id, params[:id]
    end

    render :nothing => true
  end
end
