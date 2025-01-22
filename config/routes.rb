Rails.application.routes.draw do

  devise_for :users

  root to: "cooking_classes#index"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "classes#index"

  resources :cooking_classes, only: [:index, :new, :create, :destroy, :show, :update, :edit] do
    post :book, on: :member
  end

  get "/my_cooking_classes", to: "cooking_classes#my_cooking_classes", as: :my_cooking_classes

  resources :bookings, only: [:index]
end
