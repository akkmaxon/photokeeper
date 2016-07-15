Rails.application.routes.draw do
  resources :albums do
    resources :photos, except: :index
  end

  get 'photos' => 'photos#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  root 'static_pages#welcome'
end
