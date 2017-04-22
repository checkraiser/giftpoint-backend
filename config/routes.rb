Rails.application.routes.draw do
  resources :campaigns, only: [:index, :new, :create, :edit, :update]
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'home#index'
  get '404', :to => 'application#page_not_found'
end
