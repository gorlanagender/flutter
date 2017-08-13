Rails.application.routes.draw do

  root 'pages#index'

  # Define routes for Pages.
  get 'home' => 'pages#home'
  get 'profile' => 'pages#profile'
  get 'explore' => 'pages#explore'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
