Rails.application.routes.draw do
  authenticated :user do
    root to: 'static_pages#home', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'

  devise_for :users

  resources :customers, shallow: true do
    resources :builds
    resources :rack_configs
  end

  resources :builds, only: [], shallow: true do
    resources :asset_numbers
    resources :cable_labels
    resources :label_templates
    resources :serial_numbers
  end
  post 'builds/:id/import(.:format)', to: 'builds#import', as: 'import_build'

  resources :rack_configs, only: [], shallow: true do
    resources :connections
    resources :components
  end
  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
