class PublicController < ApplicationController
  def index
    @gifs = Gif.latest.page(params[:page]).per(20)
  end
end
