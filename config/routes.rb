Rails.application.routes.draw do

  resources :products do
    collection do
      get :my
    end

    resources :comments, shallow: true, only: [:create, :destroy]
  end

  get "/search", to: "products#search"

  namespace :api do
    namespace :v1 do
      resources :products, only: [] do
        member do
          patch :like
          patch :sort
        end
      end
    end
  end

  resource :cart, only: [:show, :create, :destroy] do
    collection do
      get :checkout
    end
  end

  resources :orders, only: [:create]

  resources :cart_items, only: [:destroy]

  resource :users, except: [:destroy] do
    collection do
      get :sign_in
    end
  end

  resource :sessions, only: [:create, :destroy]

  root 'products#index'

  get '/about', to: 'pages#about', as: :about  # about_path
  get '/privacy', to: 'pages#privacy'
end
