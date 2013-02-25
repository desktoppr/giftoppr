Giftoppr::Application.routes.draw do
  post '/images/:id/download', :to => 'images#download', :as => 'image_download'

  scope "/auth" do
    match 'logout', :to => 'sessions#destroy', :as => 'auth_logout'
    match 'failure', :to => 'sessions#failure'

    # /auth/:provider is caught by the middleware. Here is just a named route
    match ':provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
    match ':provider/callback', :to => 'sessions#create'
  end

  get '/:image.gif' => 'images#show'

  root :to => 'public#index'
end
