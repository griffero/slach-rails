Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope path: '/api' do
    api_version(module: 'Api::V1', path: { value: 'v1' }, defaults: { format: 'json' }) do
      resources :users, only: [:index, :create]
      get 'users/:id', to: 'users#show', constraints: { id: /[^\/?]+/ }
      resources :payment_intents, only: [:create]
      post 'fintoc/:id/webhook', to: 'fintoc#webhook'
      post 'session', to: 'session#create'
      get 'session/:id', to: 'session#show'
    end
  end
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  devise_for :users, controllers: { confirmations: 'confirmations' }
  mount Sidekiq::Web => '/queue'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
