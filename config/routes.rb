Rails.application.routes.draw do

  resources :products

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
