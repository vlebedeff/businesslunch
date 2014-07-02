Rails.application.routes.draw do
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
end
