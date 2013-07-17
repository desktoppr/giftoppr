module SessionsHelper

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= session[:user_id].present? && User.find(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    session[:user_id] = nil
  end

end
