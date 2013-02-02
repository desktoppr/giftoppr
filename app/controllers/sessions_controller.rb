class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    user = Registration.find_or_create_user_from_auth_hash! auth_hash

    self.current_user = user

    redirect_to :root
  end

  def destroy
    self.current_user = nil

    redirect_to :root
  end

  def failure
    render :text => "Failure!"
  end
end
