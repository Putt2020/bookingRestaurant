Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :tables
  resources :restaurants
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
