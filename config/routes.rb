Rails.application.routes.draw do
  devise_for :organisations
  devise_for :interpreters

  root 'home#index'

  namespace :organisation do
    resources :appointments
  end

  namespace :interpreter do
    resources :appointments, only: [:index, :show, :update] do
      patch :assign, on: :member
    end
  end

  resources :interpreters, only: [:new, :create, :edit, :update]
  resources :organisations, only: [:new, :create, :edit, :update]
end
