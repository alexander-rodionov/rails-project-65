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

  scope module: 'web' do
    root to: 'bulletins#index'
    namespace :admin do
      root to: 'bulletins#for_moderation'
      resources :bulletins, only: %i[index show] do
        patch :publish
        patch :reject
        patch :archive
        collection do
          get :for_moderation
        end
      end
      resources :categories
    end
    resource :profile, only: %i[show]
    resources :bulletins, only: %i[index show new create edit update] do
      patch :to_moderate
      patch :archive
    end
  end

  # Опять большое неудобство, связанное с тем, что к заданию вместо требований сделан квест в стиле физмат школы.
  # Поскольку уже все было написано, а тесты завалились на названиях переменных путей, которые зависят от того как сделаны роуты
  # То надо сделать синонимы и дальше спокойно жить

  scope module: 'web' do
    patch 'bulletins/:id/archive', to: 'bulletins#archive', as: :archive_bulletin
    scope module: 'admin' do
      patch '/admin/bulletins/:bulletin_id/publish', to: 'bulletins#publish', as: :publish_admin_bulletin
      patch '/admin/bulletins/:bulletin_id/archive', to: 'bulletins#archive', as: :archive_admin_bulletin
      patch '/admin/bulletins/:bulletin_id/reject', to: 'bulletins#reject', as: :reject_admin_bulletin
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
