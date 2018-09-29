Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'

  resources :customers, shallow: true do
    resources :builds
    resources :rack_configs
  end

  resources :builds, only: [], shallow: true do
    resources :asset_numbers
    resources :serial_numbers
  end
  post 'builds/:id/import(.:format)', to: 'builds#import', as: 'import_build'

  resources :rack_configs, only: [], shallow: true do
    resources :connections
    resources :components
  end
  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'

  resources :parts do
    collection { post :import }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
