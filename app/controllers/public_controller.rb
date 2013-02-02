class PublicController < ApplicationController
  def index
    @gifs = Gif.limit(10).order('random()')
  end
end
