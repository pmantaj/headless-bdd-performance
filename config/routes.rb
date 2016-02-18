Rails.application.routes.draw do
  devise_for :users
  root 'customer#index'
  resources :customer
end
