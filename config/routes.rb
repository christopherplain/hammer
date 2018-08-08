Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'

  resources :customers

  resources :parts do
    collection { post :import }
  end

  resources :rack_configs do
    resources :elevations, only: :destroy
  end

  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
