Rails.application.routes.draw do
  get 'feed' => 'users#feed'
  get 'following' => 'users#following'
  get 'followers' => 'users#followers'

  resources :albums, only: [:index, :show, :create, :update, :destroy]
  resources :albums, only: [] do
    resources :photos
  end

  resources :photos, only: [] do
    resources :comments, only: [:create, :destroy]
  end


  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'static_pages#welcome'
end
