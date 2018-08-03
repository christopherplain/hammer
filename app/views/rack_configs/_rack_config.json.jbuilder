json.extract! rack_config, :id, :customer, :sku, :created_at, :updated_at
json.url rack_config_url(rack_config, format: :json)
