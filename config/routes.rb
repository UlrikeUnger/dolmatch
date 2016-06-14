Rails.application.routes.draw do
  devise_for :organisations
  devise_for :interpreters

  root 'home#index'
  patch '/language', to: 'languages#update'

  namespace :organisation do
    resources :appointments do
      patch :move_to_done, on: :member
    end
  end

  namespace :interpreter do
    resources :appointments, only: [:index, :show, :update] do
      patch :assign, on: :member
      get :search, on: :collection
    end
  end

  resources :interpreters, only: [:new, :create, :edit, :update]
  resources :organisations, only: [:new, :create, :edit, :update]
end
