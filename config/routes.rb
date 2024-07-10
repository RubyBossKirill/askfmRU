Rails.application.routes.draw do
  resources :users, :question, except: [:destroy]

  root "users#index"
end
