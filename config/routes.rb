Rails.application.routes.draw do
  resources :users, :questions, except: [:destroy]

  root "users#index"
end
