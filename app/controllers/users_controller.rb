class UsersController < ApplicationController

  def show
    @user = current_resource
    @images = current_resource.images.page(params[:page]).per(30)
  end

  private

    def current_resource
      @current_resource ||= User.find(params[:id]) if params[:id]
    end

end
