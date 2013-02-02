Giftoppr::Application.routes.draw do
  match '/auth/logout', :to => 'sessions#destroy', :as => 'auth_logout'
  match '/auth/failure', :to => 'sessions#failure'
  # /auth/:provider is caught by the middleware. Here is just a named route
  match '/auth/:provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
  match '/auth/:provider/callback', :to => 'sessions#create'

  root :to => 'public#index'
end
