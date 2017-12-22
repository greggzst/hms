Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'home#index'

  resources :rooms, only: [:index] do
    get :filter, on: :collection
    post :pre_book, on: :collection
    post :book, on: :collection
  end

  resources :reservations, only: [:index, :show] do
    patch :cancel, on: :member
  end
end
