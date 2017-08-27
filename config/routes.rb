Rails.application.routes.draw do

  devise_for :users
  root 'pages#index'
  devise_scope :user do
    get 'sign_in' => 'devise/sessions#new'
  end
  resource 'posts' do
    member do
      post :follow, :un_follow
    end
  end
  # Define routes for Pages.
  get 'home' => 'pages#home'
  get 'user/:id' => 'pages#profile'
  get 'explore' => 'pages#explore'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
