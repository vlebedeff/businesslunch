require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, -> u { u.manager? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'welcome#index'

  get '/dashboard' => 'dashboard#index'

  resources :orders, except: [:show] do
    patch :pay, on: :member
    patch :cancel_payment, on: :member
  end
  resources :menus, only: [:new, :create]
  resources :menu_sets, only: [:index, :edit, :update]

  resource :lunch do
    post :ready
  end

  resource :freeze, only: [:create, :destroy]
  resource :report, only: [:new, :create]
  resources :users, only: [:index] do
    resource :balance, only: [:edit, :update]
  end
end
