Giftoppr::Application.routes.draw do
  post '/images/:id/download', :to => 'images#download', :as => 'image_download'

  scope "/auth" do
    delete 'logout', :to => 'sessions#destroy', :as => 'auth_logout'
    get 'failure', :to => 'sessions#failure'

    # /auth/:provider is caught by the middleware. Here is just a named route
    get ':provider', :to => lambda { |env| [404, {}, ["Not Found"]] }, :as => 'auth'
    get ':provider/callback', :to => 'sessions#create'
  end

  get '/:image.gif' => 'images#show'

  resources :users, only: [:show, :destroy]

  root :to => 'public#index'
  get 'how-does-giftoppr-work', to: 'public#how'
end
