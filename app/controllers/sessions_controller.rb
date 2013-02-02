class SessionsController < ApplicationController
  def create
    raise auth_hash.inspect
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to :root
  end

  def failure
    render :text => "Failure!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
