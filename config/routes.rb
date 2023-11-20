Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  get '/privacy', to: 'pages#privacy'

  root 'pages#home'
end
