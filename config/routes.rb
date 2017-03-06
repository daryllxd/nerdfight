Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :users, only: %i{create update}
      resources :teams, only: %i{index}
      resources :contacts, only: %i{create index}  do
        collection { post :check }
      end
      resource :sessions, only: %i{create destroy}

      post 'sign_in', to: 'sessions#create'
      post 'sign_out', to: 'sessions#destroy'
    end
  end

  get 'api-docs', to: redirect('api-docs/index.html')
end
