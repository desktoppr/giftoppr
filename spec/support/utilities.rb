def sign_in(user)
  session[:user_id] = user.try(:id)
end