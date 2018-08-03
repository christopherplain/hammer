Rails.application.routes.draw do
  resources :rack_components
  root to: "rack_configs#index"

  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'

  resources :rack_configs, shallow: true do
    # collection { post :import }
    resources :elevations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
