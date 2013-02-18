class PublicController < ApplicationController
  def index
    @gifs = Gif.latest.page(params[:page]).per(35)
  end
end
