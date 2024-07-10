Rails.application.routes.draw do
  resources :questions
  resources :users, :question, except: [:destroy]

  root "users#index"
end
