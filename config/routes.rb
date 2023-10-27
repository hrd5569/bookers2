Rails.application.routes.draw do

  devise_for :users
  root to: 'home#top'
  get 'home/about', to: 'home#about', as: 'homes_about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:index, :show, :edit, :update, :create, :new, :destroy]
  end