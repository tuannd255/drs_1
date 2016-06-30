Rails.application.routes.draw do
  get "sessions/new"

  root "static_pages#home"

  get "help" => "static_pages#help"

  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"
  resources :users
  resources :requests, only: :create
  resources :reports, only: [:index, :create]  
  resources :relationships, only: [:index, :create, :destroy]
  resources :users, only: [:index] do 
    resources :relationships, only: [:index]
  end
  namespace :admin do
    resources :users, except: [:show, :new, :create]
    resources :positions
  end
end
