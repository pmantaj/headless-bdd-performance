Rails.application.routes.draw do
  devise_for :users
  root 'bdd#index'
  resources :bdd
end
