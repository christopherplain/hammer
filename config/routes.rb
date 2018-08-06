Rails.application.routes.draw do
  root to: "rack_configs#index"

  resources :rack_configs do
    resources :elevations, only: :destroy
  end

  post 'rack_configs/:id/import(.:format)', to: 'rack_configs#import', as: 'import_rack_config'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
