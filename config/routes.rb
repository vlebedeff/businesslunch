require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, -> u { u.manager? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  root 'welcome#index'
  patch '/disable_announcement' => 'welcome#disable_announcement'

  get '/dashboard' => 'dashboard#index'

  resource :activity, only: [:show]
  resources :groups, only: [:index] do
    post :join, on: :member
    delete :leave, on: :member
  end
  resources :orders, except: [:show] do
    patch :pay, on: :member
    patch :cancel_payment, on: :member
    patch :pay_from_balance, on: :member
  end
  resources :menus, only: [:new, :create]
  resources :menu_sets, only: [:index, :edit, :update]
  resources :vendors

  resource :lunch do
    post :ready
  end

  resource :freeze, only: [:create, :destroy]
  resource :report, only: [:new, :create]
  resources :users, only: [:index, :destroy] do
    resource :balance, only: [:edit, :update]
  end
end
