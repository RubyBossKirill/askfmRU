Rails.application.routes.draw do
  resources :users, expect: [:destroy] 

  root "users#index"
end
