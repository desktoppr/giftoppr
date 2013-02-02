Giftoppr::Application.routes.draw do
  post '/gifs/:id/download', :to => 'gifs#download', :as => 'gif_download'

  scope "/auth" do
    match 'logout', :to => 'sessions#destroy', :as => 'auth_logout'
    match 'failure', :to => 'sessions#failure'

    # /auth/:provider is caught by the middleware. Here is just a named route
    match ':provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
    match ':provider/callback', :to => 'sessions#create'
  end

  root :to => 'public#index'
end
