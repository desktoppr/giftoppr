Giftoppr::Application.routes.draw do
  # /auth/:provider is caught by the middleware. Here is just a named route
  match '/auth/:provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  root :to => 'public#index'
end
