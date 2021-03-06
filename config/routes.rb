Rails.application.routes.draw do
  devise_for :admins
  devise_for :organisations
  devise_for :interpreters

  get  'static_pages/imprint'
  get  'static_pages/contact'
  get  'static_pages/terms_and_conditions'
  root 'static_pages#home'
  patch '/language', to: 'languages#update'

  namespace :admin do
    resources :organisations
    resources :interpreters
    resources :appointments
  end

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
