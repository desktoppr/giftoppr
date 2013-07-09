class PublicController < ApplicationController
  def index
    @images = Image.latest.page(params[:page]).per(30)
  end

  def how
  end
end
