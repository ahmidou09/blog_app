Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  root "users#index"

  resources :users, only: [:index, :show] do
     resources :posts, only: [:index, :show, :new, :create, :destroy] do 
       resources :likes, only: [:create]
       resources :comments, only: [:new, :create, :destroy]
     end
   end

   namespace :api, defaults: { format: :json } do
    resources :sessions
    resources :users, only: [:index] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
