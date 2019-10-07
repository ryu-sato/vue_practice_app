Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  ActiveAdmin.routes(self)

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :employees, only: [:index, :show, :create, :update, :destroy]

      get '/liveness', to: 'statuses#liveness'
      get '/readiness', to: 'statuses#readiness'
    end
  end
end
