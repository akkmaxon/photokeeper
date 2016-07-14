Rails.application.routes.draw do
  resources :albums
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  root 'static_pages#welcome'
end
