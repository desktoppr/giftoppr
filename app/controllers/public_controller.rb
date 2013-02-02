class PublicController < ApplicationController
  def index
    @gifs = Gif.all
  end
end
