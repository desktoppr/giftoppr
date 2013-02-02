Giftoppr::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create', :as => :authorize
  match '/auth/failure', :to => 'sessions#failure'

  root :to => 'public#index'
end
