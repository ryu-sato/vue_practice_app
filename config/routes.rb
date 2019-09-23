Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'home#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :employees, only: [:index, :show, :create, :update, :destroy]

      get '/liveness', to: 'statuses#liveness'
      get '/readiness', to: 'statuses#readiness'
    end
  end
end
