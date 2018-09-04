Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'

  resources :connections

  resources :customers, shallow: true do
    resources :builds
    resources :rack_configs
  end

  resources :parts do
    collection { post :import }
  end

  resources :rack_configs, only: [], shallow: true do
    resources :connections
    resources :rack_components
  end

  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
