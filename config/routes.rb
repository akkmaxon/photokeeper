Rails.application.routes.draw do
  resources :albums, only: [:index, :show, :create, :update, :destroy]
  resources :albums, only: [] do
    resources :photos, except: :index
  end

  get 'photos' => 'photos#index'

  resources :photos, only: [] do
    resources :comments, only: [:create, :destroy]
  end


  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'static_pages#welcome'
end
