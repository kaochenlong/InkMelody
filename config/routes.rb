Rails.application.routes.draw do

  resources :products
  resource :users, except: [:destroy]

  # get '/products/new', to: 'products#new', as: :new_product
  # post '/products', to: 'products#create'
  # get '/products', to: 'products#index'
  # get '/products/:id', to: 'products#show', as: :product
  # patch '/products/:id', to: 'products#update'
  # put '/products/:id', to: 'products#update'
  # delete '/products/:id', to: 'products#destroy'
  # get '/products/:id/edit', to: 'products#edit', as: :edit_product

  root 'products#index'

  get '/about', to: 'pages#about', as: :about  # about_path
  get '/privacy', to: 'pages#privacy'
end
