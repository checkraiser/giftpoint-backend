Rails.application.routes.draw do
  resources :products, only: [:index, :new, :create] do 
  	collection do 
  	  post :import
  	end
  end
  resources :users, only: [:index, :new, :create]
  resources :customers, only: [:index] do 
  	collection do 
  	  post :import
  	  post :generate_code
  	end
  end
  resources :campaigns, only: [:index, :new, :create, :edit, :update, :show]
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'home#index'
  get '404', :to => 'application#page_not_found'
end
