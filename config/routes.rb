Rails.application.routes.draw do
  resources :users
  get 'main', to: 'users#main'
  post 'main', to: 'users#pmain'
  get 'register', to: 'users#register'
  post 'register', to: 'users#regis'
  get 'home', to: 'users#home'
  get 'editProfile', to: 'users#editProfile'
  patch 'editProfile', to: 'users#editPatchProfile'
  get 'favorite', to: 'favorites#fav'
  delete 'fav/:favID', to: 'favorites#deleteFav'
  get 'restaurantList', to: 'restaurants#resList'
  get 'restaurant/:name', to: 'restaurants#resList'
  get 'appointment/:name', to: 'appointments#appoint'
  get 'rate/:name', to: 'rates#appoint'
  get 'comment/:name', to: 'comments#appoint'

  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :tables
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
