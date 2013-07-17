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
end
