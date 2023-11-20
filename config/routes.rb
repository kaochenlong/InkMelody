Rails.application.routes.draw do
  get '/about', to: 'pages#about', as: :about  # about_path
  get '/privacy', to: 'pages#privacy'

  root 'pages#home'
end
