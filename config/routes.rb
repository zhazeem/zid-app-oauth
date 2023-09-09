Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'main#index'

  namespace :zid do
    get 'oauth/redirect'
    get 'oauth/callback'
    
    resources :webhooks, only: [:create]
  end
end
