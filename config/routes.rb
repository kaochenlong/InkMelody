Rails.application.routes.draw do

  get '/products/new', to: 'products#new', as: :new_product
  post '/products', to: 'products#create'
  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
  patch '/products/:id', to: 'products#update'
  get '/products/:id/edit', to: 'products#edit', as: :edit_product

  root 'products#index'

  get '/about', to: 'pages#about', as: :about  # about_path
  get '/privacy', to: 'pages#privacy'
end
