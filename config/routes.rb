Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  get '/dashboard' => 'dashboard#index'

  resources :orders, only: [:index]
end
