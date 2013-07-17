class UsersController < ApplicationController
  before_filter :redirect_unless_authorised

  def show
    @user = current_resource
    @images = current_resource.images.latest.page(params[:page]).per(30)
  end

  def destroy
    @user = current_resource
    if @user.destroy
      sign_out
      flash[:success] = "Your account was deleted, we're sorry that you've decided to leave!"
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to root_path
    end
  end

  private

    def redirect_unless_authorised
      redirect_to root_path unless user_signed_in? && current_user?(current_resource)
    end

    def current_resource
      @current_resource ||= User.find(params[:id]) if params[:id]
    end

end