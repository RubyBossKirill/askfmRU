Rails.application.routes.draw do
  get "sign_up" => "users#new"
  get "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:destroy] do
    resources :questions, except: [:show, :edit, :update], on: :collection
  end

  root "users#index"
end
