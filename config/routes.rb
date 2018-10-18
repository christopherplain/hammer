Rails.application.routes.draw do
  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  get 'static_pages/home'
  devise_for :users
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users', to: 'devise/registrations#update', as: 'user_registration'
  end

  resources :groups

  namespace :admin do
    resources :users
  end

  resources :customers, shallow: true do
    resources :builds
    resources :rack_configs
  end

  resources :builds, only: [], shallow: true do
    resources :asset_numbers, only: :index
    resources :cable_labels, only: :index
  end

  post 'builds/:id/import(.:format)', to: 'builds#import', as: 'import_build'
  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
