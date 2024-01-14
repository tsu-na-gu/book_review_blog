Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'images/show'
  get 'search/index'
  get 'pages/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  get 'page/:slug',
      to: 'pages#show',
      slug: /[-a-z0-9+]*/,
      as: :page

  get '/search', to: 'search#index'

  get '/tags/:name', to: 'tags#show', name: /[-a-z0-9_+]*/, as: :tag

  resources :images, only: :show

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
