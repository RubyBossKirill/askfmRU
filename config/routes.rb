Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users, except: [:destroy] do
    resources :questions, except: [:show, :edit, :update], on: :collection
  end

  root "users#index"
end
