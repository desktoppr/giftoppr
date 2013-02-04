class PublicController < ApplicationController
  def index
    @gifs = Gif.latest
  end
end
