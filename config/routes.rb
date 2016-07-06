Rails.application.routes.draw do
  get "sessions/new"

  root "static_pages#home"

  get "help" => "static_pages#help"

  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"
  get "notification" => "notification#index"

  resources :users
  resources :requests, except: [:new, :show, :destroy]
  resources :reports, only: [:index, :create, :new]  
  resources :relationships, only: [:index, :create, :destroy]
  resources :notifications, only: [:index]
  resources :users, only: [:index] do 
    resources :relationships, only: [:index]
  end
  namespace :admin do
    resources :users, except: [:show, :new, :create]
    resources :positions, except: :show
    resources :divisions 
  end
end
