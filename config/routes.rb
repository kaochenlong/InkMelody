Rails.application.routes.draw do

  # /products/new
  get '/products/new', to: 'products#new', as: :new_product
  post '/products', to: 'products#create'

  get '/about', to: 'pages#about', as: :about  # about_path
  get '/privacy', to: 'pages#privacy'

  root 'pages#home'
end
