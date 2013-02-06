Giftoppr::Application.routes.draw do
  scope "/auth" do
    match 'logout', :to => 'sessions#destroy', :as => 'auth_logout'
    match 'failure', :to => 'sessions#failure'

    # /auth/:provider is caught by the middleware. Here is just a named route
    match ':provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
    match ':provider/callback', :to => 'sessions#create'
  end

  resources :gifs, :only => [ :index ] do
    member do
      post :download
    end
  end

  root :to => 'public#index'
end
