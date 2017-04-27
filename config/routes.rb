Rails.application.routes.draw do
  resources :gift_statuses, only: [:index, :create, :find]
  get '/promotion', to: 'gift_statuses#index'
  post '/promotion', to: 'gift_statuses#create'
  post '/find_promotion', to: 'gift_statuses#find'
  resources :products, only: [:index, :new, :create] do 
  	collection do 
  	  post :import
  	end
  end
  resources :users, only: [:index, :new, :create] do 
    collection do 
      post :import_resellers
    end
  end
  resources :customers, only: [:index] do 
  	collection do 
  	  post :import
  	  post :generate_code
      get  :export
      post :approve_all
      post :import_sms
  	end
  end
  resources :campaigns, only: [:index, :new, :create, :edit, :update, :show] do 
    collection do 
      get :search
    end
  end
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'home#index'
  get '404', :to => 'application#page_not_found'
end
