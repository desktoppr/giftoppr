class PublicController < ApplicationController
  def index
    @gifs = Gif.order('random()')
  end
end
