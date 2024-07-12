Rails.application.routes.draw do
  resources :users, except: [:destroy] do
    resources :questions, except: [:show, :edit, :update], on: :collection
  end

  root "users#index"
end
