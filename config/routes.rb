# frozen_string_literal: true

Rails.application.routes.draw do
  # OmniAuth

  scope :auth do
    get :login, to: 'sessions#new'
    get :logout, to: 'sessions#destroy'

    # scope '/:provider' do
    # post '/', to: 'auth#request', as: :auth_request
    # get '/callback', to: 'sessions#create'
    # get '/callback', to: 'auth#callback', as: :callback_auth
    # end
  end

  root to: 'web/bulletin#index'

  namespace :admin do
    root to: 'bulletin#for_moderation'
    resources :bulletins, controller: 'bulletin', only: %i[index show] do
      patch :publish
      patch :reject
      collection do
        get :for_moderation
      end
    end
    resources :categories
  end

  resource :profile, controller: 'web/profile', only: %i[show]
  resources :bulletins, controller: 'web/bulletin', only: %i[index show new create edit update] do
    patch :to_moderate
    patch :archive
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
