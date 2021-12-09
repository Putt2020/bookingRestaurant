Rails.application.routes.draw do
  get 'main', to: 'users#main'
  post 'main', to: 'users#pmain'

  get 'register', to: 'users#register'
  post 'register', to: 'users#regis'

  get 'home', to: 'users#home'
  delete 'dappointment/:id', to: 'appointments#dApp'

  get 'editProfile', to: 'users#editProfile'
  patch 'editProfile', to: 'users#editPatchProfile'

  get 'favorite', to: 'favorites#fav'
  delete 'fav/:favID', to: 'favorites#deleteFavFromFavPage'

  get 'restaurantList', to: 'restaurants#resList'

  get 'restaurant/:name', to: 'restaurants#restau'
  post 'cFav/:restID', to: 'favorites#createFavFromRestPage'
  delete 'dFav/:name', to: 'favorites#deleteFavFromRestPage'
  post 'cLike/:like_tag/:commentID/:name', to: 'likes#cLike'
  patch 'pLike/:like_tag/:commentID/:name', to: 'likes#pLike'
  delete 'dLike/:commentID/:name', to: 'likes#dLike'

  get 'appointment/:name', to: 'appointments#appoint'
  post 'appointment/:name', to: 'appointments#cAppoint'

  get 'rate/:name', to: 'rates#rate'
  post 'rate/:name', to: 'rates#cRate'
  patch 'rate/:name', to: 'rates#pRate'

  get 'comment/:name', to: 'comments#comment'
  post 'comment/:name', to: 'comments#cComment'
  delete 'dcomment/:id/:name', to: 'comments#dCom' 

  resources :users
  resources :likes
  resources :comments
  resources :favorites
  resources :rates
  resources :appointments
  resources :tables
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
