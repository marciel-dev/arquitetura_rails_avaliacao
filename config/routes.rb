Rails.application.routes.draw do
  require 'sidekiq/web'

  resource :session, only: [:new, :create, :destroy]

  scope :auth do
    resources :users, only: [:new, :create]
  end

  namespace :client do
    resources :orders, only: [:index, :new, :create, :show]
  end

  namespace :admin do
    resources :orders, only: [:index, :show] do
      collection do
        post :export_report
      end
    end
    resources :users
    resources :products
  end
  get  'sign_up', to: 'registrations#new',    as: :sign_up
  post 'sign_up', to: 'registrations#create', as: :register
  
  mount Sidekiq::Web => '/sidekiq'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'
end
