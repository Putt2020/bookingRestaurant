Rails.application.routes.draw do
  resources :users
  get 'main', to: 'users#main'
  post 'main', to: 'users#pmain'
  get 'register', to: 'users#register'
  post 'register', to: 'users#regis'
  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :tables
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
